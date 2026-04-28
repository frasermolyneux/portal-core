output "staging_dashboard_name" {
  value = var.environment == "dev" ? azurerm_portal_dashboard.staging_dashboard[0].name : ""
}

output "app_insights" {
  value = {
    id                  = azurerm_application_insights.ai.id
    name                = azurerm_application_insights.ai.name
    resource_group_name = azurerm_application_insights.ai.resource_group_name
    location            = azurerm_application_insights.ai.location
  }
}

output "app_service_plans" {
  value = {
    for key, plan in azurerm_service_plan.sp :
    key => {
      id                  = plan.id
      name                = plan.name
      resource_group_name = plan.resource_group_name
      location            = plan.location
      sku                 = plan.sku_name
      os_type             = plan.os_type
    }
  }
}

output "sql_server" {
  value = {
    id                  = azurerm_mssql_server.sql.id
    name                = azurerm_mssql_server.sql.name
    resource_group_name = azurerm_mssql_server.sql.resource_group_name
    location            = azurerm_mssql_server.sql.location
    fqdn                = azurerm_mssql_server.sql.fully_qualified_domain_name
  }
}

output "servicebus_namespace" {
  value = {
    id                  = azurerm_servicebus_namespace.sb.id
    name                = azurerm_servicebus_namespace.sb.name
    resource_group_name = azurerm_servicebus_namespace.sb.resource_group_name
    location            = azurerm_servicebus_namespace.sb.location
    fqdn                = "${azurerm_servicebus_namespace.sb.name}.servicebus.windows.net"
  }
}

output "servicebus_queues" {
  value = {
    for key, queue in azurerm_servicebus_queue.queue :
    key => {
      id   = queue.id
      name = queue.name
    }
  }
}

// Central app-data storage account hosting the "ban-files" container.
// Shape matches the legacy portal-sync output of the same name so consumers
// can switch upstream without changing reference patterns.
output "ban_files_storage" {
  description = "Storage account hosting the regenerated central ban files (consumed by portal-server-agent for outbound FTP push, written by portal-sync)."
  value = {
    id             = azurerm_storage_account.app_data_storage.id
    name           = azurerm_storage_account.app_data_storage.name
    blob_endpoint  = azurerm_storage_account.app_data_storage.primary_blob_endpoint
    container_name = azurerm_storage_container.ban_files_container.name
  }
}

