provider "azurerm" {
  features {}
}

// VITRUAL NETWORK
resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "eastus"
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "my-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_location       = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}


// Identity Module
resource "azurerm_resource_group" "aks_identity_rg" {
  name     = "aks-identity-rg"
  location = "eastus"
}

module "aks_identity" {
  source                       = "./modules/identity"
  identity_resource_group_name = azurerm_resource_group.aks_identity_rg.name
  identity_name                = "aks-identity"
  location                     = azurerm_resource_group.aks_identity_rg.location
}

// Azure Container Registry
# 1. Create the Private Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "acrforinfoproprod" # Name must be alphanumeric and unique in Azure
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic" # Cost-effective entry point for development
  admin_enabled       = false   # Disabled because we use Managed Identity instead of passwords
}

# 2. Add Role Assignment so AKS can securely pull images from this ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = module.aks_identity.principal_id # Your Managed Identity
  skip_service_principal_aad_check = true
}
// AKS Cluster
# aks resource group
resource "azurerm_resource_group" "rg-aks-prod" {
  name     = "rg-aks-prod"
  location = "East US"
}

# log analytics workspace for monitoring
resource "azurerm_log_analytics_workspace" "logs" {
  name                = "law-aks-monitoring-prod"
  location            = azurerm_resource_group.rg-aks-prod.location
  resource_group_name = azurerm_resource_group.rg-aks-prod.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
# This tells Azure to grant the exact worker nodes (kubelet) access to your private ACR
resource "azurerm_role_assignment" "aks_to_acr" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = module.aks.kubelet_identity_object_id # Use the Kubelet Identity
  skip_service_principal_aad_check = true
}


module "aks" {
  source                     = "./modules/aks"
  cluster_name               = "my-aks-prod"
  resource_group_name        = "rg-aks-prod"
  location                   = "eastus"
  dns_prefix                 = "myakscluster"
  identity_id                = module.aks_identity.aks_identity
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
}