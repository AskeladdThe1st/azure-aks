resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = var.identity_name
  resource_group_name = var.identity_resource_group_name
  location            = var.location
}