locals {
  repository_function_app_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["repository_funcapp_identity"]
  repository_api_identifier_uri    = data.terraform_remote_state.portal_environments.outputs.repository_api.application.primary_identifier_uri

  repository_function_app_name     = format("fn-pcore-rp-%s-%s-%s", var.environment, var.location, random_id.environment_id.hex)
  repository_storage_account_name  = format("sarp%s", random_id.environment_id.hex)
  repository_service_bus_namespace = format("sb-pcore-rp-%s-%s-%s", var.environment, var.location, random_id.environment_id.hex)
  repository_key_vault_name        = substr(format("kv-rp-%s-%s", random_id.environment_id.hex, var.location), 0, 24)
}
