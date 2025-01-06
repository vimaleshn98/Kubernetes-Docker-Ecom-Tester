terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.14.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = "28e1e42a-4438-4c30-9a5f-7d7b488fd883"
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.

}
