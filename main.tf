terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "5.21.0"
    }
  }
}

provider "azurerm" {
  features {
    # we only set this to false because this is a workshop demo environment
    # do not use this in production
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id            = "03cb196c-1987-4307-bd86-6eec05256c6f"
  skip_provider_registration = true
}

locals {
  location = "West Europe"
}


provider "google" {
  project = "ea-workshop-ea-worksho-2wp"
  region  = "europe-west1"
}
