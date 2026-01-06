locals {
  api_spec_storage_account_name = format("sapspec%s", random_id.environment_id.hex)
  api_spec_containers           = ["event-ingest"]
  portal_event_ingest_principal = data.terraform_remote_state.platform_workloads.outputs.workload_service_principals["portal-event-ingest"][var.environment]
}

resource "azurerm_storage_account" "api_spec" {
  name                     = local.api_spec_storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  public_network_access_enabled   = true

  tags = var.tags
}

resource "azurerm_storage_container" "api_spec" {
  for_each = toset(local.api_spec_containers)

  name                  = each.key
  storage_account_id    = azurerm_storage_account.api_spec.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "portal_event_ingest_spec_storage_contributor" {
  scope                = azurerm_storage_account.api_spec.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = local.portal_event_ingest_principal.service_principal_id
}
