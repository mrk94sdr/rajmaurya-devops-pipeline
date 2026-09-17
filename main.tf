terraform {
    backend "azurerm" {
    resource_group_name  = "amit_rg"
    storage_account_name = "amitstorage32345"
    container_name       = "amitcontainer"
    key                  = "prod.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "amit_rg"
  location = "centralindia"
}

resource "azurerm_storage_account" "stg" {
  name                     = "amitstorage32345"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "con" {
  name                  = "amitcontainer"
  storage_account_id    = azurerm_storage_account.stg.id
  container_access_type = "private"

}