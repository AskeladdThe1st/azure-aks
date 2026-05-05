resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version = var.kubernetes_version
  dns_prefix          = var.dns_prefix
  local_account_disabled = false
  oidc_issuer_enabled = true
  workload_identity_enabled = true
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  default_node_pool {
    name       = "systempool"
    node_count = 1
    vm_size    = "Standard_DC2s_v3"
    os_disk_size_gb     = 128
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  tags = {
    Environment = "Production"
  }
# Networking configuration (Example assumes standard Azure CNI)
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}
