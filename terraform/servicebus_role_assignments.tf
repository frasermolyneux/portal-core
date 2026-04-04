resource "azurerm_role_assignment" "server_agent_servicebus_sender" {
  scope                = azurerm_servicebus_namespace.sb.id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = local.managed_identities["server_agent"].principal_id
}

resource "azurerm_role_assignment" "server_events_servicebus_receiver" {
  scope                = azurerm_servicebus_namespace.sb.id
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = local.managed_identities["server_events"].principal_id
}
