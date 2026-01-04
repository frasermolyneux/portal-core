resource "azurerm_api_management" "apim" {
  name = local.api_management_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  publisher_name  = "XtremeIdiots"
  publisher_email = "admin@xtremeidiots.com"

  sku_name = "Consumption_0"

  identity {
    type         = "UserAssigned"
    identity_ids = [local.core_api_management_identity.id]
  }
}
