variable "identity_name" {
  type        = string
  description = "The name of the user assigned identity to create."
  default     = "UserAssigned" # Explicit value defined here
}

variable "identity_resource_group_name" {
  type        = string
  description = "The Azure Resource Group name."
  default     = "my-aks-rg" # Explicit value defined here
}

variable "location" {
  type        = string
  description = "The Azure Region."
  default     = "eastus" # Explicit value defined here
}
