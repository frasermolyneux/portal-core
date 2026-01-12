resource "azurerm_mssql_server" "sql" {
  name = local.sql_server_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  version             = "12.0"
  minimum_tls_version = "1.2"

  azuread_administrator {
    azuread_authentication_only = true
    login_username              = local.sql_admin_group.display_name
    object_id                   = local.sql_admin_group.object_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [local.sql_server_identity.id]
  }

  primary_user_assigned_identity_id = local.sql_server_identity.id

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "sql" {
  name      = "allowAzureServicesFirewallRule"
  server_id = azurerm_mssql_server.sql.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
