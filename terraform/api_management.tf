resource "azurerm_api_management_logger" "app_insights" {
  name                = "${var.workload_name}-application-insights"
  resource_group_name = data.azurerm_api_management.api_management.resource_group_name
  api_management_name = data.azurerm_api_management.api_management.name

  application_insights {
    instrumentation_key = azurerm_application_insights.ai.instrumentation_key
  }
}

resource "azurerm_api_management_diagnostic" "app_insights" {
  identifier               = "applicationinsights"
  resource_group_name      = data.azurerm_api_management.api_management.resource_group_name
  api_management_name      = data.azurerm_api_management.api_management.name
  api_management_logger_id = azurerm_api_management_logger.app_insights.id

  sampling_percentage = lookup(local.app_insights_sampling_percentage, var.environment, 25)
  always_log_errors   = true
  log_client_ip       = true
  verbosity           = "information"

  backend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  backend_response {
    body_bytes     = 0
    headers_to_log = []
  }

  frontend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  frontend_response {
    body_bytes     = 0
    headers_to_log = []
  }
}
