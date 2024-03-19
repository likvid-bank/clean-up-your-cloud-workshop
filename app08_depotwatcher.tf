resource "azurerm_resource_group" "depotwatcher" {
  name     = "depotwatcher-rg"
  location = local.location

  tags = {
    app_id = "app08"
  }
}


resource "azurerm_subnet" "depotwatcher" {
  name                 = "depotwatcher-sn"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_static_web_app" "depotwatcher" {
  name                = "depotwatcher"
  resource_group_name = azurerm_resource_group.depotwatcher.name
  location            = azurerm_resource_group.depotwatcher.location

  tags = {
    app_id = "app08"
  }
}

resource "azurerm_kubernetes_cluster" "depotwatcher" {
  name                = "depotwatcher-aks"
  location            = azurerm_resource_group.depotwatcher.location
  resource_group_name = azurerm_resource_group.depotwatcher.name
  dns_prefix          = "depotwatcheraks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    app_id = "app08"
  }
}
