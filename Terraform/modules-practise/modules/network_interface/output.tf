output "public_ips" {
  value = [for public_ip in azurerm_public_ip.agent_public_ips : public_ip.ip_address]
}
# output "network_interface_ids" {
#   description = "network interface ids"
#   value       = azurerm_network_interface.nic.id
# }
output "network_interface_ids" {
  description = "Network interface IDs"
  value       = [for nic in azurerm_network_interface.agent_nic : nic.id]
}


