resource "azurerm_resource_group" "capstoneRG" {
  name     = "capstoneRG"
  location = "East US"
}

resource "azurerm_network_security_group" "capstoneSG" {
  name                = "capstone-security-group"
  location            = azurerm_resource_group.capstoneRG.location
  resource_group_name = azurerm_resource_group.capstoneRG.name
  
    security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
    security_rule {
    name                       = "http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "capstoneVnet" {
  name                = "capstone-vnet"
  location            = azurerm_resource_group.capstoneRG.location
  resource_group_name = azurerm_resource_group.capstoneRG.name
  address_space       = ["10.0.0.0/16"]
}
  
 resource "azurerm_subnet" "capstoneSubnet" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.capstoneRG.name
  virtual_network_name = azurerm_virtual_network.capstoneVnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "capstoneVnic" {
  name                = "capstone-nic"
  location            = azurerm_resource_group.capstoneRG.location
  resource_group_name = azurerm_resource_group.capstoneRG.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.capstoneSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
resource "azurerm_public_ip" "pip" {
  name                         = "azure-pip"
  location                     = azurerm_resource_group.capstoneRG.location
  resource_group_name          = azurerm_resource_group.capstoneRG.name
  allocation_method   = "Static"
  idle_timeout_in_minutes      = 30
}

resource "azurerm_network_interface_security_group_association" "nsgassoc" {
  network_interface_id      = azurerm_network_interface.capstoneVnic.id
  network_security_group_id = azurerm_network_security_group.capstoneSG.id
}

variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_virtual_machine" "capstonevm" {
  name                  = "capstone-vm"
  location              = azurerm_resource_group.capstoneRG.location
  resource_group_name   = azurerm_resource_group.capstoneRG.name
  network_interface_ids = [azurerm_network_interface.capstoneVnic.id]
  vm_size               = "Standard_B1ms"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "azurevm"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
 output "vm_public_ip" {
  value = azurerm_public_ip.pip.id
  }
