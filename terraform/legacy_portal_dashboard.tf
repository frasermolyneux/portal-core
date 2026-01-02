locals {
  legacy_input = file("dashboards/dashboard.json")

  legacy_dashboard_replacements = {
    "subscription_id"       = var.subscription_id
    "resource_group_name"   = azurerm_resource_group.legacy_rg.name
    "app_insights_name"     = azurerm_application_insights.legacy_ai.name
    "app_service_plan_name" = azurerm_service_plan.legacy_sp.name
    "api_management_name"   = azurerm_api_management.legacy_apim.name
    "sql_server_name"       = azurerm_mssql_server.legacy_sql.name
    "key_vault_name"        = azurerm_key_vault.legacy_sql_kv.name
  }

  legacy_out = join("\n", [
    for line in split("\n", local.legacy_input) :
    format(
      replace(line, "/{(${join("|", keys(local.legacy_dashboard_replacements))})}/", "%s"),
      [
        for value in flatten(regexall("{(${join("|", keys(local.legacy_dashboard_replacements))})}", line)) :
        lookup(local.legacy_dashboard_replacements, value)
      ]...
    )
  ])
}

resource "azurerm_portal_dashboard" "legacy_app" {
  name = local.legacy_dashboard_name

  resource_group_name = azurerm_resource_group.legacy_rg.name
  location            = azurerm_resource_group.legacy_rg.location

  tags = var.tags

  dashboard_properties = local.legacy_out
}

moved {
  from = azurerm_portal_dashboard.app
  to   = azurerm_portal_dashboard.legacy_app
}

resource "azurerm_portal_dashboard" "legacy_staging_dashboard" {
  count = var.environment == "dev" ? 1 : 0
  name  = "${local.legacy_dashboard_name}-staging"

  resource_group_name = azurerm_resource_group.legacy_rg.name
  location            = azurerm_resource_group.legacy_rg.location

  tags = var.tags

  dashboard_properties = local.legacy_out

  lifecycle {
    ignore_changes = [
      dashboard_properties
    ]
  }
}

moved {
  from = azurerm_portal_dashboard.staging_dashboard
  to   = azurerm_portal_dashboard.legacy_staging_dashboard
}
