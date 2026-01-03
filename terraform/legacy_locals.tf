locals {
  legacy_resource_group_name   = "rg-portal-core-${var.environment}-${var.location}-${var.instance}"
  legacy_app_insights_name     = "ai-portal-core-${var.environment}-${var.location}-${var.instance}"
  legacy_app_service_plan_name = "asp-portal-core-${var.environment}-${var.location}-${var.instance}"
  legacy_api_management_name   = "apim-portal-core-${var.environment}-${var.location}-${var.instance}-${random_id.legacy_environment_id.hex}"
  legacy_sql_server_name       = "sql-portal-core-${var.environment}-${var.location}-${var.instance}-${random_id.legacy_environment_id.hex}"
  legacy_key_vault_name        = substr(format("kv-%s-%s", random_id.legacy_environment_id.hex, var.location), 0, 24)
  legacy_dashboard_name        = "portal-core-${var.environment}-${var.instance}"
}
