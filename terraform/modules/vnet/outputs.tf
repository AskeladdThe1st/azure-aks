# virtual network outputs
output "vnet_location" {
  value = azurerm_virtual_network.vnet.location
}
output "resource_group_name" {
  value = azurerm_virtual_network.vnet.resource_group_name
}
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "address_space" {
  value = azurerm_virtual_network.vnet.address_space
}
output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}