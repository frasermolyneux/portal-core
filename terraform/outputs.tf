output "staging_dashboard_name" {
  value = var.environment == "dev" ? azurerm_portal_dashboard.staging_dashboard[0].name : ""
}

output "app_insights" {
  value = {
    name = azurerm_application_insights.ai.name
    id   = azurerm_application_insights.ai.id
  }
}

output "app_service_plans" {
  value = {
    for key, plan in azurerm_service_plan.sp :
    key => {
      name    = plan.name
      id      = plan.id
      sku     = plan.sku_name
      os_type = plan.os_type
    }
  }
}

output "sql_server" {
  value = {
    name = azurerm_mssql_server.sql.name
    id   = azurerm_mssql_server.sql.id
    fqdn = azurerm_mssql_server.sql.fully_qualified_domain_name
  }
}

