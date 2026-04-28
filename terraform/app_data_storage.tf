// Central app-data storage for shared blob assets used across portal-* workloads.
//
// Currently hosts the "ban-files" container — the regenerated central ban file
// blobs produced by portal-sync (writer) and consumed by portal-server-agent
// (reader, which then pushes them to game servers via FTP).
//
// Owned by portal-core because the asset has multiple producers/consumers and
// must outlive the nightly destroy-development cycle of any single leaf
// workload. See docs/ban-files-storage.md for the full migration history.

resource "azurerm_storage_account" "app_data_storage" {
  name = local.app_data_storage_name

  resource_group_name = local.workload_resource_group.name
  location            = local.workload_resource_group.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  // Identity-based access only — no shared keys, no SFTP local users.
  local_user_enabled        = false
  shared_access_key_enabled = false

  tags = var.tags
}

resource "azurerm_storage_container" "ban_files_container" {
  name = "ban-files"

  storage_account_id    = azurerm_storage_account.app_data_storage.id
  container_access_type = "private"
}

// Role assignments scoped to the storage account. Owned here (not by the
// consumer repos) so the storage account and its access grants share a
// single lifecycle — avoids the cross-workload destroy-ordering bug we hit
// when the storage account lived in portal-sync.

// portal-sync function app — writes regenerated ban file blobs.
resource "azurerm_role_assignment" "sync_to_app_data_storage" {
  scope                = azurerm_storage_account.app_data_storage.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = local.managed_identities["sync"].principal_id
  description          = "portal-sync function app writes regenerated central ban file blobs."
}

// portal-server-agent container app — reads regenerated ban file blobs and
// pushes them to game servers via FTP.
resource "azurerm_role_assignment" "server_agent_to_app_data_storage" {
  scope                = azurerm_storage_account.app_data_storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = local.managed_identities["server_agent"].principal_id
  description          = "portal-server-agent container app reads central ban file blobs to push to game servers."
}
