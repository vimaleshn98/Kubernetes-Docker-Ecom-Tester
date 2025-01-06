output "storage_account_name" {
  description = "storage account name"
  value       = azurerm_storage_account.backup.name
}

output "container_name" {
  description = "storage account name"
  value       = azurerm_storage_container.container.name
}
