data "azurerm_client_config" "current" {}

resource "random_id" "legacy_environment_id" {
  byte_length = 6
}

moved {
  from = random_id.environment_id
  to   = random_id.legacy_environment_id
}

resource "time_rotating" "legacy_thirty_days" {
  rotation_days = 30
}

moved {
  from = time_rotating.thirty_days
  to   = time_rotating.legacy_thirty_days
}

resource "random_id" "legacy_lock" {
  keepers = {
    id = "${timestamp()}"
  }
  byte_length = 8
}

moved {
  from = random_id.lock
  to   = random_id.legacy_lock
}
