variable "azure_resource_group_name" {
  type        = string
  description = "azure resource group name"
}

variable "azure_resource_group_location" {
  type        = string
  description = "azure resources location"
}

variable "vmlist" {
  type        = list(string)
  description = "list of vm"
}


variable "company" {
  type        = string
  description = "Company name for resource tagging"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
}


#### network ####

variable "prefix" {
  type        = string
  description = "azure vet prefix name"
}

variable "address_space" {
  type        = list(string)
  description = "value of cidr"
}


variable "address_prefixes" {
  type        = list(string)
  description = "azure subnet address prefixes"
}
variable "azurerm_public_ip_name" {
  type        = string
  description = "value of azurerm_public_ip_name"
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
variable "public_ip_names" {
  type = list(string)
}



######### vm ##############
variable "vm_name" {
  type = string

}

variable "admin_username" {
  type = string
}
variable "ssh_key_path" {
  type = string
  #"~/.ssh/id_rsa.pub"
}
variable "ssh_private_key_path" {
  type = string
  #"~/.ssh/id_rsa.pub"
}
variable "ssh_adminuser" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "os_disk_variable" {
  type = object({
    caching              = string
    storage_account_type = string
  })
}


variable "source_image_reference_variable" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "command_to_run" {
  type = list(string)
}

# variable "network_interface_ids" {
#   type = list(string)
# }


# variable "subnet_id" {
#   type        = string
#   description = "azure subnet id"
# }
#####backend########

variable "azure_storage_name" {
  type        = string
  description = "azure stroage name"
}


variable "storage_account_tier" {
  type        = string
  description = "azure stroage name"
}


variable "account_replication_type" {
  type        = string
  description = "azure stroage name"
}

variable "azurerm_storage_container_name" {
  type        = string
  description = "azure stroage name"
}

variable "container_access_type" {
  type        = string
  description = "azure stroage name"
}

variable "backup_key" {
  type        = string
  description = "azure stroage name"
}


###################agent##################

variable "agent_public_ip_names" {
  type = list(string)
}

variable "agent_public_ip_allocation_method" {
  type        = string
  description = "value of public_ip_allocation_method"
}

variable "agent_security_rule" {
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


variable "agent_azurerm_network_interface_name" {
  type = string
}

variable "agent_azurerm_network_interface_ip_configuration_name" {
  type = string

}
variable "agent_azurerm_network_interface_ip_configuration_private_ip_address_allocation" {
  type = string
}
variable "agent_public_ip_sku" {
  type = string
}


variable "agent_vm_name" {
  type = string

}

variable "agent_admin_username" {
  type = string
}
variable "agent_ssh_key_path" {
  type = string
  #"~/.ssh/id_rsa.pub"
}
variable "agent_ssh_private_key_path" {
  type = string
  #"~/.ssh/id_rsa.pub"
}
variable "agent_ssh_adminuser" {
  type = string
}

variable "agent_vm_size" {
  type = string
}

variable "agent_os_disk_variable" {
  type = object({
    caching              = string
    storage_account_type = string
  })
}


variable "agent_source_image_reference_variable" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "agent_command_to_run" {
  type = list(string)
}

variable "agent_vmlist" {
  type        = list(string)
  description = "list of vm"
}
