output "resource_group_name" {
  description = "Resource group containing the LIFELINE network resources."
  value       = azurerm_resource_group.network.name
}

output "virtual_networks" {
  description = "Created VNet names and address spaces."
  value = {
    for key, vnet in azurerm_virtual_network.this : key => {
      name          = vnet.name
      address_space = vnet.address_space
      location      = vnet.location
    }
  }
}

output "subnets" {
  description = "Created subnet names, prefixes and IDs."
  value = {
    for key, subnet in azurerm_subnet.this : key => {
      name             = subnet.name
      address_prefixes = subnet.address_prefixes
      id               = subnet.id
    }
  }
}
