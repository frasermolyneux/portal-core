resource "azurerm_api_management_api_version_set" "repository_api" {
  name                = "repository-api"
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_management_name = azurerm_api_management.apim.name

  display_name      = "Event Ingest API"
  versioning_scheme = "Segment"
}

resource "azurerm_api_management_product" "repository_api" {
  product_id          = "repository-api"
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_management_name = azurerm_api_management.apim.name

  display_name = "Event Ingest API"

  subscription_required = true
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_product_policy" "repository_api" {
  product_id          = azurerm_api_management_product.repository_api.product_id
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_management_name = azurerm_api_management.apim.name

  xml_content = <<XML
<policies>
  <inbound>
      <base/>
      <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none" />
      <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="JWT validation was unsuccessful" require-expiration-time="true" require-scheme="Bearer" require-signed-tokens="true">
          <openid-config url="https://login.microsoftonline.com/${data.azuread_client_config.current.tenant_id}/v2.0/.well-known/openid-configuration" />
          <audiences>
          <audience>${local.repository_api_identifier_uri}</audience>
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
