// Product and policy moved back to portal-event-ingest. Drop state without deleting the resources.

removed {
  from = azurerm_api_management_api_version_set.event_ingest_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product.event_ingest_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product_policy.event_ingest_api

  lifecycle {
    destroy = false
  }
}
