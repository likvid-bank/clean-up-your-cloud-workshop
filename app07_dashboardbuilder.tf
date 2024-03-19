resource "azurerm_resource_group" "app_2" {
  name     = "dashboardbuilder-rg"
  location = local.location

  tags = {
    app_id = "app07"
  }
}


resource "azurerm_subnet" "app_2" {
  name                 = "dashboardbuilder-sn"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "app_2" {
  name                = "dashboardbuilder-nic"
  location            = azurerm_resource_group.app_2.location
  resource_group_name = azurerm_resource_group.app_2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_2.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    app_id = "app07"
  }
}

resource "azurerm_linux_virtual_machine" "app_2" {
  name                = "dashboardbuilder-machine"
  resource_group_name = azurerm_resource_group.app_2.name
  location            = azurerm_resource_group.app_2.location
  size                = "Standard_A1_v2"
  admin_username      = "app_2_admin"
  network_interface_ids = [
    azurerm_network_interface.app_2.id,
  ]

  admin_ssh_key {
    username   = "app_2_admin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    app_id = "app07"
  }
}
