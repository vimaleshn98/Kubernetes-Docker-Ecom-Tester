variable "azure_resource_group_name" {
  type        = string
  description = "azure resource group name"
}

variable "azure_resource_group_location" {
  type        = string
  description = "azure resources location"
}

variable "tags" {
  type        = map(string)
  description = "map of tags we want to add"
}
