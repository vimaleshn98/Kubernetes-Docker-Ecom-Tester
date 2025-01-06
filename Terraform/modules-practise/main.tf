# module "resource_group" {
#   source                        = "./modules/resource_group"
#   azure_resource_group_name     = var.azure_resource_group_name
#   azure_resource_group_location = var.azure_resource_group_location
#   tags                          = local.common_tags
# }


#imported resource group cloud guru doesn't premit to create other rg
# resource "azurerm_resource_group" "my_rg" {
#   name     = "1-a8b27dc1-playground-sandbox"
#   location = "westus"
#   tags     = local.common_tags
# }


module "network_infra" {
  source        = "./modules/network"
  prefix        = var.prefix
  address_space = var.address_space
  # azure_resource_group_name                                                = azurerm_resource_group.my_rg.name
  # azure_resource_group_location                                            = azurerm_resource_group.my_rg.location
  azure_resource_group_name                                                = var.azure_resource_group_name
  azure_resource_group_location                                            = var.azure_resource_group_location
  address_prefixes                                                         = var.address_prefixes
  public_ip_names                                                          = var.public_ip_names
  public_ip_allocation_method                                              = var.public_ip_allocation_method
  security_rule                                                            = var.security_rule
  azurerm_network_interface_name                                           = var.azurerm_network_interface_name
  azurerm_network_interface_ip_configuration_name                          = var.azurerm_network_interface_ip_configuration_name
  azurerm_network_interface_ip_configuration_private_ip_address_allocation = var.azurerm_network_interface_ip_configuration_private_ip_address_allocation
  public_ip_sku                                                            = var.public_ip_sku
}


module "vm_infra" {
  source  = "./modules/vm"
  vm_name = var.vm_name
  vmlist  = var.vmlist
  # azure_resource_group_location   = azurerm_resource_group.my_rg.location
  # azure_resource_group_name       = azurerm_resource_group.my_rg.name
  azure_resource_group_name       = var.azure_resource_group_name
  azure_resource_group_location   = var.azure_resource_group_location
  vm_size                         = var.vm_size
  source_image_reference_variable = var.source_image_reference_variable
  admin_username                  = var.admin_username
  os_disk_variable                = var.os_disk_variable
  network_interface_ids           = module.network_infra.network_interface_ids
  command_to_run                  = var.command_to_run
  ssh_adminuser                   = var.ssh_adminuser
  ssh_key_path                    = var.ssh_key_path
  ssh_private_key_path            = var.ssh_private_key_path
}


module "storage_account_backup" {
  source                         = "./modules/storage"
  container_access_type          = var.container_access_type
  storage_account_tier           = var.storage_account_tier
  azure_resource_group_name      = var.azure_resource_group_name
  azure_resource_group_location  = var.azure_resource_group_location
  azurerm_storage_container_name = var.azurerm_storage_container_name
  azure_storage_name             = var.azure_storage_name
  account_replication_type       = var.account_replication_type
}


