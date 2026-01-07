resource "azurerm_api_management_api_version_set" "legacy_servers_integration_api" {
  name                = "servers-integration-api"
  resource_group_name = azurerm_api_management.legacy_apim.resource_group_name
  api_management_name = azurerm_api_management.legacy_apim.name

  display_name      = "Servers Integration API"
  versioning_scheme = "Segment"
}

resource "azurerm_api_management_product" "legacy_servers_integration_api" {
  product_id          = "servers-integration-api"
  resource_group_name = azurerm_api_management.legacy_apim.resource_group_name
  api_management_name = azurerm_api_management.legacy_apim.name

  display_name = "Servers Integration API"

  subscription_required = true
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_product_policy" "legacy_servers_integration_api" {
  product_id          = azurerm_api_management_product.legacy_servers_integration_api.product_id
  resource_group_name = azurerm_api_management.legacy_apim.resource_group_name
  api_management_name = azurerm_api_management.legacy_apim.name

  xml_content = <<XML
<policies>
  <inbound>
      <base/>
      <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none" />
      <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="JWT validation was unsuccessful" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true">
          <openid-config url="https://login.microsoftonline.com/${data.azuread_client_config.current.tenant_id}/v2.0/.well-known/openid-configuration" />
          <audiences>
          <audience>${local.servers_integration_api_identifier_uri}</audience>
          </audiences>
          <issuers>
              <issuer>https://sts.windows.net/${data.azuread_client_config.current.tenant_id}/</issuer>
          </issuers>
          <required-claims>
              <claim name="roles" match="any">
                <value>EventGenerator</value>
              </claim>
          </required-claims>
      </validate-jwt>
  </inbound>
  <backend>
      <forward-request />
  </backend>
  <outbound>
      <base/>
      <cache-store duration="3600" />
  </outbound>
  <on-error />
</policies>
XML
}

import {
  to = azurerm_api_management_api_version_set.legacy_servers_integration_api
  id = "${azurerm_api_management.legacy_apim.id}/apiVersionSets/servers-integration-api"
}

import {
  to = azurerm_api_management_product.legacy_servers_integration_api
  id = "${azurerm_api_management.legacy_apim.id}/products/servers-integration-api"
}

import {
  to = azurerm_api_management_product_policy.legacy_servers_integration_api
  id = "${azurerm_api_management.legacy_apim.id}/products/servers-integration-api"
}
