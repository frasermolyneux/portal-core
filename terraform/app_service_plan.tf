resource "azurerm_service_plan" "sp" {
  for_each = local.app_service_plans

  name = each.value.name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  os_type  = each.value.os_type
  sku_name = each.value.sku
}
