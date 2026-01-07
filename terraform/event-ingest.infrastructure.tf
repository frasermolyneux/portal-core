resource "azurerm_storage_account" "event_ingest_function_app_storage" {
  name                = local.event_ingest_storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  local_user_enabled        = false
  shared_access_key_enabled = false

  tags = var.tags
}

resource "azurerm_role_assignment" "event_ingest_storage_blob_owner" {
  scope                = azurerm_storage_account.event_ingest_function_app_storage.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = local.event_ingest_function_app_identity.principal_id
}

resource "azurerm_servicebus_namespace" "event_ingest" {
  name                = local.event_ingest_service_bus_namespace
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = var.tags

  sku = "Basic"

  local_auth_enabled = false
}

resource "azurerm_servicebus_queue" "event_ingest" {
  for_each = local.event_ingest_queue_names

  name         = each.value
  namespace_id = azurerm_servicebus_namespace.event_ingest.id
}

resource "azurerm_role_assignment" "event_ingest_servicebus_receiver" {
  scope                = azurerm_servicebus_namespace.event_ingest.id
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = local.event_ingest_function_app_identity.principal_id
}

resource "azurerm_role_assignment" "event_ingest_servicebus_sender" {
  scope                = azurerm_servicebus_namespace.event_ingest.id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = local.event_ingest_function_app_identity.principal_id
}

resource "azurerm_key_vault" "event_ingest" {
  name                = local.event_ingest_key_vault_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = var.tags

  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  rbac_authorization_enabled = true

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }
}

resource "azurerm_role_assignment" "event_ingest_kv_secrets_user" {
  scope                = azurerm_key_vault.event_ingest.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = local.event_ingest_function_app_identity.principal_id
}

resource "azurerm_role_assignment" "event_ingest_apim_kv_role_assignment" {
  scope                = azurerm_key_vault.event_ingest.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = local.core_api_management_identity.principal_id
}

resource "azurerm_role_assignment" "event_ingest_kv_secrets_officer" {
  scope                = azurerm_key_vault.event_ingest.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azuread_client_config.current.object_id
}
