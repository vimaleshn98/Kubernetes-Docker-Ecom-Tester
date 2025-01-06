variable "vm_name" {
  type = string

}

variable "vmlist" {
  type        = list(string)
  description = "list of vm"
}

variable "azure_resource_group_name" {
  type        = string
  description = "azure resource group name"
}

variable "azure_resource_group_location" {
  type        = string
  description = "azure resources location"
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

variable "network_interface_ids" {
  type = list(string)
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
