resource "azurerm_resource_group" "rnd" {
  name     = "rnd"
  location = local.location
}

resource "azurerm_subnet" "rnd" {
  name                 = "rnd-sn"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.11.0/24"]
}

resource "azurerm_network_interface" "dashboardbuilder_mess" {
  name                = "dashboardbuilder-dev-nic"
  location            = azurerm_resource_group.rnd.location
  resource_group_name = azurerm_resource_group.rnd.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.rnd.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "dashboardbuilder_mess" {
  name                = "dashboardbuilder-dev-machine"
  resource_group_name = azurerm_resource_group.rnd.name
  location            = azurerm_resource_group.rnd.location
  size                = "Standard_A1_v2"
  admin_username      = "securepostbox_admin"
  network_interface_ids = [
    azurerm_network_interface.dashboardbuilder_mess.id,
  ]

  admin_ssh_key {
    username   = "securepostbox_admin"
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
}

resource "azurerm_network_interface" "depotwatcher_mess" {
  name                = "depotwatcher-dev-nic"
  location            = azurerm_resource_group.rnd.location
  resource_group_name = azurerm_resource_group.rnd.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.rnd.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "depotwatcher_mess" {
  name                = "depotwatcher-dev-machine"
  resource_group_name = azurerm_resource_group.rnd.name
  location            = azurerm_resource_group.rnd.location
  size                = "Standard_A1_v2"
  admin_username      = "securepostbox_admin"
  network_interface_ids = [
    azurerm_network_interface.depotwatcher_mess.id,
  ]

  admin_ssh_key {
    username   = "securepostbox_admin"
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
}
