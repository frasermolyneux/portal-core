locals {
  resource_group_name = "rg-portal-core-${var.environment}-${var.location}-${var.instance}"
  app_insights_name   = "ai-portal-core-${var.environment}-${var.location}-${var.instance}"
}
