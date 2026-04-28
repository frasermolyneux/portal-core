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

  sql_server_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["sql_server"]

  managed_identities = data.terraform_remote_state.portal_environments.outputs.managed_identities

  # Local Resource Naming
  app_insights_name = "ai-portal-core-${var.environment}-${var.location}"
  app_service_plans = {
    for key, plan in var.app_service_plans :
    key => {
      name    = "asp-${var.workload_name}-${var.environment}-${var.location}-${key}"
      sku     = plan.sku
      os_type = plan.os_type
    }
  }
  sql_server_name           = "sql-portal-core-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  servicebus_namespace_name = "sb-portal-core-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  app_data_storage_name     = "sappdata${random_id.environment_id.hex}"
  dashboard_name            = "portal-core-${var.environment}"

  servicebus_queues = {
    "player-connected"    = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "player-disconnected" = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "chat-message"        = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "server-connected"    = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "map-change"          = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "server-status"       = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "ban-file-changed"    = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
    "player-ip-resolved"  = { max_delivery_count = 5, lock_duration = "PT5M", dead_lettering_on_message_expiration = true }
  }

  app_insights_sampling_percentage = {
    dev = 10
    prd = 25
  }
}
