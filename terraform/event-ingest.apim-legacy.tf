// Legacy product/version set moved back to portal-event-ingest. Drop state without deleting the resources.

removed {
  from = azurerm_api_management_api_version_set.legacy_event_ingest_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product.legacy_event_ingest_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product_policy.legacy_event_ingest_api

  lifecycle {
    destroy = false
  }
}
