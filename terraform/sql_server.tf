resource "azuread_group" "sql_admin_group" {
  display_name     = local.sql_admin_group_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_id" "username_suffix" {
  byte_length = 4
}

resource "azurerm_key_vault" "sql_kv" {
  name                = local.sql_key_vault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = var.tags

  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  enable_rbac_authorization  = true

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }
}

resource "azurerm_key_vault_secret" "sql_username" {
  name         = "${local.sql_name}-username"
  value        = "addy${random_id.username_suffix.hex}"
  key_vault_id = azurerm_key_vault.sql_kv.id
}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "${local.sql_name}-password"
  value        = random_password.sql_admin_password.result
  key_vault_id = azurerm_key_vault.sql_kv.id
}

resource "azurerm_mssql_server" "sql" {
  name = "mssqlserver"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  version                      = "12.0"
  administrator_login          = azurerm_key_vault_secret.sql_username.value
  administrator_login_password = azurerm_key_vault_secret.sql_password.value
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = azuread_group.sql_admin_group.display_name
    object_id      = azuread_group.sql_admin_group.object_id
  }

  tags = var.tags
}
