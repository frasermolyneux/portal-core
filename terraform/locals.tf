locals {
  resource_group_name   = "rg-portal-core-${var.environment}-${var.location}-${var.instance}"
  app_insights_name     = "ai-portal-core-${var.environment}-${var.location}-${var.instance}"
  app_service_plan_name = "asp-portal-core-${var.environment}-${var.location}-${var.instance}"
  api_management_name   = "apim-portal-core-${var.environment}-${var.location}-${var.instance}-${random_id.environment_id.hex}"
}
