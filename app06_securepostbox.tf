resource "azurerm_resource_group" "securepostbox" {
  name     = "securepostbox-rg"
  location = local.location

  tags = {
    app_id = "app06"
  }
}


resource "azurerm_subnet" "securepostbox" {
  name                 = "securepostbox-sn"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_interface" "securepostbox_1" {
  name                = "db-nic"
  location            = azurerm_resource_group.securepostbox.location
  resource_group_name = azurerm_resource_group.securepostbox.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.securepostbox.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    app_id = "app06"
  }
}

resource "azurerm_linux_virtual_machine" "securepostbox_1" {
  name                = "db-machine"
  resource_group_name = azurerm_resource_group.securepostbox.name
  location            = azurerm_resource_group.securepostbox.location
  size                = "Standard_A1_v2"
  admin_username      = "securepostbox_admin"
  network_interface_ids = [
    azurerm_network_interface.securepostbox_1.id,
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

  tags = {
    app_id = "app06"
  }
}


resource "azurerm_network_interface" "securepostbox_2" {
  name                = "frontend-nic"
  location            = azurerm_resource_group.securepostbox.location
  resource_group_name = azurerm_resource_group.securepostbox.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.securepostbox.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    app_id = "app06"
  }
}

resource "azurerm_linux_virtual_machine" "securepostbox_2" {
  name                = "frontend-machine"
  resource_group_name = azurerm_resource_group.securepostbox.name
  location            = azurerm_resource_group.securepostbox.location
  size                = "Standard_A1_v2"
  admin_username      = "securepostbox_admin"
  network_interface_ids = [
    azurerm_network_interface.securepostbox_2.id,
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

  tags = {
    app_id = "app06"
  }
}
