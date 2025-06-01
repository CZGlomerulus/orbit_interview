resource "azurerm_network_security_group" "backend_nsg" {
  name                = "nsg-backend"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Postgres-Out"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5432"]
    source_address_prefix      = "10.3.1.0/24"
    destination_address_prefix = "10.3.2.0/24"
  }
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = "nsg-db"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Postgres-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["5432"]
    source_address_prefix      = "10.3.1.0/24"
    destination_address_prefix = "10.3.2.0/24"
  }
}

resource "azurerm_subnet_network_security_group_association" "backend_assoc" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "db_assoc" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}
