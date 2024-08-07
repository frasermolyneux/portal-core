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

variable "sql_admin_aad_group_members" {
  type    = list(string)
  default = []
}

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
