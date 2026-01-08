output "resource_group_name" {
  value = azurerm_resource_group.legacy_rg.name
}

output "staging_dashboard_name" {
  value = var.environment == "dev" ? azurerm_portal_dashboard.staging_dashboard[0].name : ""
}

output "app_insights" {
  value = {
    name = azurerm_application_insights.legacy_ai.name
    id   = azurerm_application_insights.legacy_ai.id
  }
}

