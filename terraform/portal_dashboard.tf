locals {
  input = file("dashboards/dashboard.json")

  dashboard_replacements = {
    "subscription_id"       = var.subscription_id
    "resource_group_name"   = azurerm_resource_group.rg.name
    "app_insights_name"     = azurerm_application_insights.ai.name
    "app_service_plan_name" = azurerm_service_plan.sp.name
    "api_management_name"   = azurerm_api_management.apim.name
    "sql_server_name"       = azurerm_mssql_server.sql.name
    "key_vault_name"        = azurerm_key_vault.sql_kv.name
  }

  out = join("\n", [
    for line in split("\n", local.input) :
    format(
      replace(line, "/{(${join("|", keys(local.dashboard_replacements))})}/", "%s"),
      [
        for value in flatten(regexall("{(${join("|", keys(local.dashboard_replacements))})}", line)) :
        lookup(local.dashboard_replacements, value)
      ]...
    )
  ])
}

resource "azurerm_portal_dashboard" "app" {
  name = local.dashboard_name

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  tags = var.tags

  dashboard_properties = local.out
}

resource "azurerm_portal_dashboard" "staging_dashboard" {
  count = var.environment == "dev" ? 1 : 0
  name  = "${local.dashboard_name}-staging"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  tags = var.tags

  dashboard_properties = local.out

  lifecycle {
    ignore_changes = [
      dashboard_properties
    ]
  }
}
