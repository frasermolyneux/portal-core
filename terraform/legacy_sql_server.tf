resource "random_password" "legacy_sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_id" "legacy_username_suffix" {
  byte_length = 4
}

resource "azurerm_key_vault_secret" "legacy_sql_username" {
  name         = "${local.legacy_sql_server_name}-username"
  value        = "addy${random_id.legacy_username_suffix.hex}"
  key_vault_id = azurerm_key_vault.legacy_sql_kv.id

  depends_on = [azurerm_role_assignment.legacy_deploy_spn_key_vault_secrets_officer]
}

resource "azurerm_key_vault_secret" "legacy_sql_password" {
  name         = "${local.legacy_sql_server_name}-password"
  value        = random_password.legacy_sql_admin_password.result
  key_vault_id = azurerm_key_vault.legacy_sql_kv.id

  depends_on = [azurerm_role_assignment.legacy_deploy_spn_key_vault_secrets_officer]
}

resource "azurerm_mssql_server" "legacy_sql" {
  name = local.legacy_sql_server_name

  location            = azurerm_resource_group.legacy_rg.location
  resource_group_name = azurerm_resource_group.legacy_rg.name

  version                      = "12.0"
  administrator_login          = azurerm_key_vault_secret.legacy_sql_username.value
  administrator_login_password = azurerm_key_vault_secret.legacy_sql_password.value
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = local.legacy_sql_admin_group.display_name
    object_id      = local.legacy_sql_admin_group.object_id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "legacy_example" {
  name      = "allowAzureServicesFirewallRule"
  server_id = azurerm_mssql_server.legacy_sql.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
