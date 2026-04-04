resource "azurerm_servicebus_namespace" "sb" {
  name = local.servicebus_namespace_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  sku = var.servicebus_namespace.sku

  local_auth_enabled = false

  tags = var.tags
}

resource "azurerm_servicebus_queue" "queue" {
  for_each = local.servicebus_queues

  name         = each.key
  namespace_id = azurerm_servicebus_namespace.sb.id

  max_delivery_count                   = each.value.max_delivery_count
  lock_duration                        = each.value.lock_duration
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration
}
