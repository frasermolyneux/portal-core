environment = "prd"
location    = "uksouth"
instance    = "01"

subscription_id = "32444f38-32f4-409f-889c-8e8aa2b5b4d1"

platform_workloads_state = {
  resource_group_name  = "rg-tf-platform-workloads-prd-uksouth-01"
  storage_account_name = "sadz9ita659lj9xb3"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
  tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
}

log_analytics_subscription_id     = "d68448b0-9947-46d7-8771-baa331a3063a"
log_analytics_resource_group_name = "rg-platform-logging-prd-uksouth-01"
log_analytics_workspace_name      = "log-platform-prd-uksouth-01"

app_service_plan = {
  sku = "B3"
}

tags = {
  Environment = "prd",
  Workload    = "portal-core",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/portal-core"
}

portal_environments_state_resource_group_name  = "rg-tf-portal-environments-prd-uksouth-01"
portal_environments_state_storage_account_name = "sad74a6da165e7"
portal_environments_state_container_name       = "tfstate"
portal_environments_state_key                  = "terraform.tfstate"
portal_environments_state_subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
portal_environments_state_tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
