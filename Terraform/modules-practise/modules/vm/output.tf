# output "public_ip" {
#   value = azurerm_linux_virtual_machine.globo_vm.public_ip_address
# }
# output "public_ip" {
#   value = [for vm in azurerm_linux_virtual_machine.globo_vm : azurerm_linux_virtual_machine.globo_vm[vm.key].public_ip_address]
# }
