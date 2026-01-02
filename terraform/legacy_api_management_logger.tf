resource "azurerm_api_management_named_value" "legacy_apim_nv_ai_key" {
  name                = "${azurerm_application_insights.legacy_ai.name}-instrumentationkey"
  resource_group_name = azurerm_api_management.legacy_apim.resource_group_name
  api_management_name = azurerm_api_management.legacy_apim.name

  display_name = "${azurerm_application_insights.legacy_ai.name}-instrumentationkey"

  value = azurerm_application_insights.legacy_ai.instrumentation_key
}

resource "azurerm_api_management_logger" "legacy_apim_log" {
  name                = azurerm_application_insights.legacy_ai.name
  api_management_name = azurerm_api_management.legacy_apim.name
  resource_group_name = azurerm_api_management.legacy_apim.resource_group_name

  resource_id = azurerm_application_insights.legacy_ai.id

  application_insights {
    instrumentation_key = "{{${azurerm_api_management_named_value.legacy_apim_nv_ai_key.display_name}}}"
  }
}

moved {
  from = azurerm_api_management_named_value.apim_nv_ai_key
  to   = azurerm_api_management_named_value.legacy_apim_nv_ai_key
}

moved {
  from = azurerm_api_management_logger.apim_log
  to   = azurerm_api_management_logger.legacy_apim_log
}
