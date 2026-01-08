// Legacy product/version set moved to portal-repository. Drop state without deleting the resources.

removed {
  from = azurerm_api_management_api_version_set.legacy_repository_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product.legacy_repository_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product_policy.legacy_repository_api

  lifecycle {
    destroy = false
  }
}
