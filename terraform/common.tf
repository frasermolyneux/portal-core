resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_management_lock" "rg_lock" {
  name       = "Terraform Lock - ${random_id.lock.hex}"
  scope      = azurerm_resource_group.rg.id
  lock_level = "ReadOnly"
  notes      = "Lock managed by Terraform to prevent manual change or accidental deletion of the resource group or resources"
}
