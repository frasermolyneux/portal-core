// Legacy product/version set moved to portal-servers-integration. Drop state without deleting the resources.

removed {
  from = azurerm_api_management_api_version_set.legacy_servers_integration_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product.legacy_servers_integration_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product_policy.legacy_servers_integration_api

  lifecycle {
    destroy = false
  }
}
