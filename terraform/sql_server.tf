resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_id" "username_suffix" {
  byte_length = 4
}

resource "azurerm_key_vault_secret" "sql_username" {
  name         = "${local.sql_server_name}-username"
  value        = "addy${random_id.username_suffix.hex}"
  key_vault_id = azurerm_key_vault.sql_kv.id

  depends_on = [azurerm_role_assignment.deploy_spn_key_vault_secrets_officer]
}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "${local.sql_server_name}-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.sql_kv.id

  depends_on = [azurerm_role_assignment.deploy_spn_key_vault_secrets_officer]
}

resource "azurerm_mssql_server" "sql" {
  name = local.sql_server_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  version                      = "12.0"
  administrator_login          = azurerm_key_vault_secret.sql_username.value
  administrator_login_password = azurerm_key_vault_secret.sql_password.value
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = local.sql_admin_group.display_name
    object_id      = local.sql_admin_group.object_id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "sql" {
  name      = "allowAzureServicesFirewallRule"
  server_id = azurerm_mssql_server.sql.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
