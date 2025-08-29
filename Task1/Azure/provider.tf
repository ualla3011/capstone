terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "df4218a8-1553-4763-9c11-a9d922d01d95"
  tenant_id       = "347d1228-8668-4cf4-bf10-bb7b3abf9ccc"
  resource_provider_registrations = "none"

  features {}
}
