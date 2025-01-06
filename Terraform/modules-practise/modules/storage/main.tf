# Create Storage Account
resource "azurerm_storage_account" "backup" {
  name                     = var.azure_storage_name
  resource_group_name      = var.azure_resource_group_name
  location                 = var.azure_resource_group_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.account_replication_type
}

# Create Blob Container
resource "azurerm_storage_container" "container" {
  name                  = var.azurerm_storage_container_name
  storage_account_id    = azurerm_storage_account.backup.id
  container_access_type = var.container_access_type
}
