variable "cluster_name" {
  type        = string
  description = "The name of the AKS cluster."
  default     = "aks-cluster-prod"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the AKS cluster will be created."
}

variable "location" {
  type        = string
  description = "The Azure region for the deployment."
  default     = "East US"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the managed cluster."
  default     = "aks-prod"
}

variable "kubernetes_version" {
  type        = string
  description = "The version of Kubernetes to use."
  default     = "1.33"
}

variable "identity_id" {
  type        = string
  description = "The Resource ID of the User Assigned Managed Identity."
}
variable "log_analytics_workspace_id" {
  type        = string
  description = "The Resource ID of the existing Azure Log Analytics Workspace."
}

