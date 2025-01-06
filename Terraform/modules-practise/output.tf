output "public_ip" {
  description = "public ip of vm "
  value       = module.network_infra.public_ips
}
# output "resource_group_location" {
#   description = "The location of the resource group"
#   value       = azurerm_resource_group.my_rg.name
# }
