output "resource_group_name" {
  value = azurerm_resource_group.legacy_rg.name
}

output "staging_dashboard_name" {
  value = var.environment == "dev" ? azurerm_portal_dashboard.legacy_staging_dashboard[0].name : ""
}

output "api_management" {
  value = {
    name                = azurerm_api_management.legacy_apim.name
    id                  = azurerm_api_management.legacy_apim.id
    resource_group_name = azurerm_api_management.legacy_apim.resource_group_name
    gateway_url         = azurerm_api_management.legacy_apim.gateway_url
  }
}

output "api_management_identity" {
  value = {
    id           = local.core_api_management_identity.id
    client_id    = local.core_api_management_identity.client_id
    principal_id = local.core_api_management_identity.principal_id
  }
}

output "app_insights" {
  value = {
    name = azurerm_application_insights.legacy_ai.name
    id   = azurerm_application_insights.legacy_ai.id
  }
}

