variable "environment" {
  default = "dev"
}

variable "location" {
  default = "uksouth"
}

variable "instance" {
  default = "01"
}

variable "subscription_id" {}

variable "log_analytics_subscription_id" {}
variable "log_analytics_resource_group_name" {}
variable "log_analytics_workspace_name" {}

variable "app_service_plan" {
  type = object({
    sku = string
  })
}

variable "tags" {
  default = {}
}

variable "portal_environments_state_resource_group_name" {}

variable "portal_environments_state_storage_account_name" {}

variable "portal_environments_state_container_name" {
  default = "tfstate"
}

variable "portal_environments_state_key" {
  default = "terraform.tfstate"
}

variable "portal_environments_state_subscription_id" {}

variable "portal_environments_state_tenant_id" {}
