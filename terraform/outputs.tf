output "aks_identity_principal_id" {
  value       = module.aks_identity.principal_id
  description = "The principal ID of the identity (useful for role assignments)"
}
output "client_id" {
  value       = module.aks_identity.client_id
  description = "The client ID of the identity (useful for AKS configuration)"
}
output "principal_id" {
  value       = module.aks_identity.principal_id
  description = "The principal ID of the identity (useful for role assignments)"
}