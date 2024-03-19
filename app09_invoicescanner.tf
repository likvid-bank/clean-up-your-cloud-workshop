resource "azurerm_resource_group" "invoicescanner" {
  name     = "invoicescanner-rg"
  location = local.location
}


resource "azurerm_subnet" "invoicescanner" {
  name                 = "invoicescanner-sn"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_cognitive_account" "invoicescanner" {
  name                = "invoicescanner-ca"
  location            = azurerm_resource_group.invoicescanner.location
  resource_group_name = azurerm_resource_group.invoicescanner.name
  kind                = "ComputerVision"
  sku_name            = "S1"
}

resource "azurerm_storage_account" "invoicescanner" {
  name                     = "invoicescannerinboxsa"
  resource_group_name      = azurerm_resource_group.invoicescanner.name
  location                 = azurerm_resource_group.invoicescanner.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
