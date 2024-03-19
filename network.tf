resource "azurerm_resource_group" "network" {
  name     = "network-rg"
  location = local.location

  tags = {
    environment = "production"
  }
}

resource "azurerm_network_security_group" "network" {
  name                = "prod-sg"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_virtual_network" "network" {
  name                = "prod-vnet"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "production"
  }
}


