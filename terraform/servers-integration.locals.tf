locals {
  servers_integration_function_app_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["servers_integration_webapp_identity"]
  servers_integration_api_identifier_uri    = data.terraform_remote_state.portal_environments.outputs.servers_integration_api.application.primary_identifier_uri
}
