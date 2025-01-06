resource "azurerm_resource_group" "my_rg" {
  name     = var.azure_resource_group_name
  location = var.azure_resource_group_location
  tags     = var.tags
}
