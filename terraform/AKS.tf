resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.aks_cluster_name}"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.backend.id
    upgrade_settings {
        drain_timeout_in_minutes      = 0
        max_surge                     = "10%"
        node_soak_duration_in_minutes = 0
            }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.4.0.0/16"
    dns_service_ip    = "10.4.0.10"
  }

  depends_on = [azurerm_subnet.backend]

}