variable "prefix" {
  type        = string
  description = "azure vet prefix name"
}

variable "address_space" {
  type        = list(string)
  description = "value of cidr"
}

variable "azure_resource_group_name" {
  type        = string
  description = "azure resource group name"
}

variable "azure_resource_group_location" {
  type        = string
  description = "azure resources location"
}

variable "address_prefixes" {
  type        = list(string)
  description = "azure subnet address prefixes"
}
# variable "azurerm_public_ip_name" {
#   type        = string
#   description = "value of azurerm_public_ip_name"
# }

variable "public_ip_names" {
  type = list(string)
}
variable "public_ip_allocation_method" {
  type        = string
  description = "value of public_ip_allocation_method"
}

variable "security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "list of security rules"
}


variable "azurerm_network_interface_name" {
  type = string
}

variable "azurerm_network_interface_ip_configuration_name" {
  type = string

}
variable "azurerm_network_interface_ip_configuration_private_ip_address_allocation" {
  type = string
}

variable "public_ip_sku" {
  type = string
}
