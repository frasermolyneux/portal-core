// Product/version set moved to portal-repository. Drop state without deleting the resources.

removed {
  from = azurerm_api_management_api_version_set.repository_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product.repository_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_product_policy.repository_api

  lifecycle {
    destroy = false
  }
}
