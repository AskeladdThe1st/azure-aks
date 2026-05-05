output "aks_cluster_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "The Resource ID of the AKS cluster."
}

output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster."
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  description = "The OIDC issuer URL, required for configuring Workload Identity."
}

output "node_resource_group" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "The auto-generated Resource Group containing the cluster's underlying infrastructure."
}
