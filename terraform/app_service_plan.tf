resource "azurerm_service_plan" "sp" {
  name = local.app_service_plan_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  os_type  = "Linux"
  sku_name = var.app_service_plan.sku
}
