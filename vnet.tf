# === Create a virtual network ===
resource "azurerm_virtual_network" "vnet" {
  name                = "BeStrong_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.BeStrong.location
  resource_group_name = azurerm_resource_group.BeStrong.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "appsvc-subnet"
  resource_group_name  = azurerm_resource_group.BeStrong.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  service_endpoints = ["Microsoft.KeyVault"]

  delegation {
    name = "appsvc-delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

# https://learn.microsoft.com/en-us/answers/questions/1528559/cant-create-private-endpoint-because-of-subnet-del
resource "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "private-endpoints-subnet"
  resource_group_name  = azurerm_resource_group.BeStrong.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}