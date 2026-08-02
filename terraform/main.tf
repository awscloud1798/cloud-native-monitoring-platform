resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-${var.environment}-rg"
  location = var.location
  tags     = var.common_tags
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}${var.environment}acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
  tags                = var.common_tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-${var.environment}-aks"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.prefix}-${var.environment}"

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.common_tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                             = azurerm_container_registry.acr.id
  skip_service_principal_aad_check  = true
}
