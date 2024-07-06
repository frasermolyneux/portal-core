resource "azuread_group" "sql_admin_group" {
  display_name     = local.sql_admin_group_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
