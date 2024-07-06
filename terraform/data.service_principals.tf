data "azuread_service_principal" "workload" {
  for_each = { for each in var.sql_admin_aad_group_members : each => each }

  display_name = each.value
}
