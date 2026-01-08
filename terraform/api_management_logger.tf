resource "azurerm_api_management_named_value" "apim_nv_ai_key" {
  name = "${azurerm_application_insights.ai.name}-instrumentationkey"

  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name

  display_name = "${azurerm_application_insights.ai.name}-instrumentationkey"

  value = azurerm_application_insights.ai.instrumentation_key
}

resource "azurerm_api_management_logger" "apim_log" {
  name = azurerm_application_insights.ai.name

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  resource_id = azurerm_application_insights.ai.id

  application_insights {
    instrumentation_key = "{{${azurerm_api_management_named_value.apim_nv_ai_key.display_name}}}"
  }
}
