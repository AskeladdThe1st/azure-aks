output "aks_identity" {
  value = azurerm_user_assigned_identity.aks_identity.id
}
output "client_id" {
  value = azurerm_user_assigned_identity.aks_identity.client_id
}
output "principal_id" {
  value = azurerm_user_assigned_identity.aks_identity.principal_id
}
output "name" {
  value = azurerm_user_assigned_identity.aks_identity.name
}
output "resource_group_name" {
  value = azurerm_user_assigned_identity.aks_identity.resource_group_name
}