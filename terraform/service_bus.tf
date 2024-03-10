resource "azurerm_servicebus_namespace" "sb" {
  name = local.service_bus_name

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku = var.environment == "prd" ? "Premium" : "Standard"

  tags = var.tags
}

resource "azurerm_servicebus_queue" "batch_inbound" {
  name         = "batch-inbound"
  namespace_id = azurerm_servicebus_namespace.sb.id
}
