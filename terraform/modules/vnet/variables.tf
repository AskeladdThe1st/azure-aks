variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
}
variable "vnet_name" {
  description = "The name of the virtual network to create."
  type        = string
}
variable "vnet_location" {
  description = "The location of the virtual network to create."
  type        = string
}
variable "address_space" {
  description = "The address space of the virtual network to create."
  type        = list(string)
}
