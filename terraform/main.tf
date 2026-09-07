# Stage 01: Core network boundaries
#
# WHAT: Create the resource group, VNets and initial workload subnets.
# WHY:  LIFELINE needs separate routing domains before we intentionally connect them.
# WHAT BREAKS WITHOUT IT: There is no address plan or network boundary on which later
#                         routing, security, private access and delivery services can build.

resource "azurerm_resource_group" "network" {
  name     = local.resource_group_name
  location = var.primary_location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "this" {
  for_each = local.vnets

  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = each.value.address_space
  tags                = local.common_tags
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.this[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}
