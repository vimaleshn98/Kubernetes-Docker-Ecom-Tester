
module "network_nic" {
  source                                                                   = "./modules/network_interface"
  prefix                                                                   = var.prefix
  public_ip_names                                                          = var.agent_public_ip_names
  azure_resource_group_name                                                = var.azure_resource_group_name
  azure_resource_group_location                                            = var.azure_resource_group_location
  subnet_id                                                                = module.network_infra.network_subnet_ids
  public_ip_allocation_method                                              = var.agent_public_ip_allocation_method
  security_rule                                                            = var.agent_security_rule
  azurerm_network_interface_name                                           = var.agent_azurerm_network_interface_name
  azurerm_network_interface_ip_configuration_name                          = var.agent_azurerm_network_interface_ip_configuration_name
  azurerm_network_interface_ip_configuration_private_ip_address_allocation = var.agent_azurerm_network_interface_ip_configuration_private_ip_address_allocation
  public_ip_sku                                                            = var.agent_public_ip_sku
}


module "jenkins_agent_vm_infra" {
  source                          = "./modules/vm"
  vm_name                         = var.agent_vm_name
  vmlist                          = var.agent_vmlist
  azure_resource_group_name       = var.azure_resource_group_name
  azure_resource_group_location   = var.azure_resource_group_location
  vm_size                         = var.agent_vm_size
  source_image_reference_variable = var.agent_source_image_reference_variable
  admin_username                  = var.agent_admin_username
  os_disk_variable                = var.agent_os_disk_variable
  network_interface_ids           = module.network_nic.network_interface_ids
  command_to_run                  = var.agent_command_to_run
  ssh_adminuser                   = var.agent_ssh_adminuser
  ssh_key_path                    = var.agent_ssh_key_path
  ssh_private_key_path            = var.agent_ssh_private_key_path
}
