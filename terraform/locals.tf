locals {
  # Remote State References
  workload_resource_groups = {
    for location in [var.location] :
    location => data.terraform_remote_state.platform_workloads.outputs.workload_resource_groups[var.workload_name][var.environment].resource_groups[lower(location)]
  }

  workload_resource_group = local.workload_resource_groups[var.location]

  platform_monitoring_workspace_id = data.terraform_remote_state.platform_monitoring.outputs.log_analytics.id

  monitor_action_groups = data.terraform_remote_state.platform_monitoring.outputs.monitor_action_groups

  sql_admin_group = data.terraform_remote_state.portal_environments.outputs.sql_admin_group

  core_sql_server_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["core_sql_server_identity"]

  # Local Resource Naming
  app_insights_name     = "ai-portal-core-${var.environment}-${var.location}"
  app_service_plan_name = "asp-portal-core-${var.environment}-${var.location}"
  sql_server_name       = "sql-portal-core-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  dashboard_name        = "portal-core-${var.environment}"
}
