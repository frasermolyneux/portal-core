resource "azurerm_application_insights" "ai" {
  name = local.app_insights_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  workspace_id = local.platform_monitoring_workspace_id

  application_type = "web"

  disable_ip_masking = true
}
