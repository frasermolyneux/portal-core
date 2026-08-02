// Shared cache storage account used by portal-repository (Repository API) for:
//
//   * Ephemeral Repository API cache-aside entries (MxCaching TableStorage backend).
//   * LiveStatus status + player records (moved off the previous per-workload
//     account as part of the Phase 2 caching work — data is agent-refreshed
//     ~60s so there is no migration).
//
// Only the Repository API managed identity accesses this account directly in
// this phase; other portal-* workloads read the same cached data via the
// Repository API rather than touching Table Storage themselves. Additional
// service-principal grants should therefore be added deliberately and scoped
// to the least-privilege Storage Table data role.
//
// Table creation is intentionally left to the consuming applications
// (TableStorageLiveStatusStore and MxCaching's TableStorage backend both
// CreateIfNotExists their own tables via managed identity at startup). This
// avoids the azurerm_storage_table data-plane path, which historically has
// required shared keys — this account keeps shared_access_key_enabled = false
// and matches the identity-only posture of app_data_storage.

resource "azurerm_storage_account" "cache_storage" {
  # Ephemeral cache-only account — accepted risk posture matches app_data_storage.
  # checkov:skip=CKV_AZURE_206: LRS is sufficient for ephemeral cache data (LiveStatus is agent-refreshed ~60s; MxCaching entries are regenerable). GRS/ZRS is an unjustified cost for this workload.
  # checkov:skip=CKV_AZURE_190: No blob containers are created on this account; only Table Storage is used.
  # checkov:skip=CKV_AZURE_59: Public network access is required — portal-repository App Service reaches this account over the public endpoint using managed identity; private endpoints are out of scope on cost/architecture grounds.
  # checkov:skip=CKV_AZURE_33: Queue Storage is not used on this account.
  # checkov:skip=CKV2_AZURE_38: Soft-delete is unnecessary for ephemeral cache/LiveStatus data that is regenerable in seconds.
  # checkov:skip=CKV2_AZURE_33: Private endpoint intentionally not provisioned (cost/architecture decision, consistent with app_data_storage).
  # checkov:skip=CKV2_AZURE_47: No blob containers exposed; `allow_nested_items_to_be_public` defaults to disabled and the account is identity-only.
  # checkov:skip=CKV2_AZURE_1: Platform-managed keys are acceptable — cache/LiveStatus is not classified data and CMK adds Key Vault + rotation cost with no threat-model benefit here.
  name = local.cache_storage_name

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

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

// portal-repository Repository API — reads and writes ephemeral cache entries
// and LiveStatus records via managed identity. Scoped to the cache account
// only; this is the sole service principal touching the shared cache account
// directly in Phase 2 Part 1.
resource "azurerm_role_assignment" "repository_to_cache_storage" {
  scope                = azurerm_storage_account.cache_storage.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = local.managed_identities["repository"].principal_id
  description          = "portal-repository Repository API reads/writes ephemeral cache entries (MxCaching) and LiveStatus status/player records via managed identity."
}
