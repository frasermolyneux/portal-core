environment = "dev"
location    = "uksouth"
instance    = "01"

subscription_id = "d68448b0-9947-46d7-8771-baa331a3063a"

log_analytics_subscription_id     = "d68448b0-9947-46d7-8771-baa331a3063a"
log_analytics_resource_group_name = "rg-platform-logging-prd-uksouth-01"
log_analytics_workspace_name      = "log-platform-prd-uksouth-01"

app_service_plan = {
  sku = "B2"
}

tags = {
  Environment = "dev",
  Workload    = "portal-core",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/portal-core"
}

portal_environments_state_resource_group_name  = "rg-tf-portal-environments-dev-uksouth-01"
portal_environments_state_storage_account_name = "sab36aeb79781b"
portal_environments_state_container_name       = "tfstate"
portal_environments_state_key                  = "terraform.tfstate"
portal_environments_state_subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
portal_environments_state_tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
