locals {
  event_ingest_function_app_identity = data.terraform_remote_state.portal_environments.outputs.managed_identities["event_ingest_funcapp_identity"]
  event_ingest_api_identifier_uri    = data.terraform_remote_state.portal_environments.outputs.event_ingest_api.application.primary_identifier_uri

  event_ingest_function_app_name     = format("fn-pcore-ei-%s-%s-%s", var.environment, var.location, random_id.environment_id.hex)
  event_ingest_storage_account_name  = format("saei%s", random_id.environment_id.hex)
  event_ingest_service_bus_namespace = format("sb-pcore-ei-%s-%s-%s", var.environment, var.location, random_id.environment_id.hex)
  event_ingest_key_vault_name        = substr(format("kv-ei-%s-%s", random_id.environment_id.hex, var.location), 0, 24)
  event_ingest_queue_names = {
    player_connected = "player_connected_queue"
    chat_message     = "chat_message_queue"
    map_vote         = "map_vote_queue"
    server_connected = "server_connected_queue"
    map_change       = "map_change_queue"
  }
}
