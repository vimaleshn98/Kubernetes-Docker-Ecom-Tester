output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_virtual_network.vnet.name
}

output "public_ips" {
  value = [for public_ip in azurerm_public_ip.public_ips : public_ip.ip_address]
}
# output "network_interface_ids" {
#   description = "network interface ids"
#   value       = azurerm_network_interface.nic.id
# }
output "network_interface_ids" {
  description = "Network interface IDs"
  value       = [for nic in azurerm_network_interface.nic : nic.id]
}

output "network_subnet_ids" {
  description = "Network subnet IDs"
  value       = azurerm_subnet.subnet.id
}
