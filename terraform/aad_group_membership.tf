resource "azuread_group_member" "group_membership" {
  for_each = { for each in var.sql_admin_aad_group_members : each => each }

  group_object_id  = azuread_group.sql_admin_group.id
  member_object_id = data.azuread_service_principal.workload[each.value].object_id
}
