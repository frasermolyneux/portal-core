resource "azurerm_role_assignment" "web_app_insights_monitoring_reader" {
  scope                = azurerm_application_insights.ai.id
  role_definition_name = "Monitoring Reader"
  principal_id         = local.managed_identities["web"].principal_id
}
