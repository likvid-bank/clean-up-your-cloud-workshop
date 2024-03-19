terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id            = "03cb196c-1987-4307-bd86-6eec05256c6f"
  skip_provider_registration = true
}

locals {
  location = "West Europe"
}
