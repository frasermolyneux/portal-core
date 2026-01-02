resource "azurerm_api_management" "legacy_apim" {
  name                = local.legacy_api_management_name
  location            = azurerm_resource_group.legacy_rg.location
  resource_group_name = azurerm_resource_group.legacy_rg.name

  publisher_name  = "XtremeIdiots"
  publisher_email = "admin@xtremeidiots.com"

  sku_name = "Consumption_0"

  identity {
    type = "SystemAssigned"
  }
}

moved {
  from = azurerm_api_management.apim
  to   = azurerm_api_management.legacy_apim
}
