locals {
  # Remote State References
  workload_resource_groups = {
    for location in [var.location] :
    location => data.terraform_remote_state.platform_workloads.outputs.workload_resource_groups[var.workload_name][var.environment].resource_groups[lower(location)]
  }

  workload_backend = try(
    data.terraform_remote_state.platform_workloads.outputs.workload_terraform_backends[var.workload_name][var.environment],
    null
  )

  workload_administrative_unit = try(
    data.terraform_remote_state.platform_workloads.outputs.workload_administrative_units[var.workload_name][var.environment],
    null
  )

  workload_resource_group = local.workload_resource_groups[var.location]

  platform_monitoring_workspace_id = data.terraform_remote_state.platform_monitoring.outputs.log_analytics.id

  sql_admin_group = data.terraform_remote_state.portal_environments.outputs.sql_admin_group

  portal_core_sql_server_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["portal_core_sql_server_identity"]

  # Local Resource Naming
  app_insights_name     = "ai-portal-core-${var.environment}-${var.location}"
  api_management_name   = "apim-portal-core-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  app_service_plan_name = "asp-portal-core-${var.environment}-${var.location}"
  key_vault_name        = substr(format("kv-%s-%s", random_id.environment_id.hex, var.location), 0, 24)
  sql_server_name       = "sql-portal-core-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  dashboard_name        = "portal-core-${var.environment}"
}
