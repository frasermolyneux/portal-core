locals {
  event_ingest_function_app_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["event_ingest_funcapp_identity"]
  event_ingest_api_identifier_uri    = data.terraform_remote_state.portal_environments.outputs.event_ingest_api.application.primary_identifier_uri
}
