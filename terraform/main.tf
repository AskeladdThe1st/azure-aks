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

module "aks" {
  source                     = "./modules/aks"
  cluster_name               = "my-aks-prod"
  resource_group_name        = "rg-aks-prod"
  location                   = "eastus"
  dns_prefix                 = "myakscluster"
  kubernetes_version         = "1.30"
  identity_id                = module.aks_identity.aks_identity
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
}