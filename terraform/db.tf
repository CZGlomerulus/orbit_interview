resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "pg-flex-001"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "13"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  zone                   = "1"
  public_network_access_enabled = false

  delegated_subnet_id    = azurerm_subnet.db.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgres.id


  authentication {
    active_directory_auth_enabled = true
    password_auth_enabled         = false

  }

}

resource "azurerm_postgresql_flexible_server_database" "db1" {
  name      = "db1"
  server_id = azurerm_postgresql_flexible_server.db.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_private_dns_zone" "postgres" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "vnet-link"
  resource_group_name = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}