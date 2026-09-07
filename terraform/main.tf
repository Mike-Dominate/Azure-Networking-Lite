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

  dynamic "delegation" {
    for_each = try(each.value.delegation_name, null) == null ? [] : [each.value.delegation_name]

    content {
      name = "delegation-${each.key}"

      service_delegation {
        name    = delegation.value
        actions = try(each.value.delegation_actions, null)
      }
    }
  }
}

# Stage 02: Hub-and-spoke peering
#
# WHAT: Create explicit peering links between the Hub and each spoke in both directions.
# WHY:  Different VNets are isolated routing domains until a connectivity mechanism exists.
# WHAT BREAKS WITHOUT IT: Workloads in the App, Data and Operations VNets have no private
#                         VNet-to-VNet path to shared services in the Hub.
#
# We intentionally define each direction explicitly rather than hiding the topology in a
# loop. Azure models each peering direction as its own resource, and serial dependencies
# also avoid concurrent peering updates while the topology is being created.

resource "azurerm_virtual_network_peering" "hub_to_app" {
  count = var.enable_hub_spoke_peering ? 1 : 0

  name                      = "peer-hub-to-app"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["app"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "app_to_hub" {
  count = var.enable_hub_spoke_peering ? 1 : 0

  name                      = "peer-app-to-hub"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.this["app"].name
  remote_virtual_network_id = azurerm_virtual_network.this["hub"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_peering.hub_to_app]
}

resource "azurerm_virtual_network_peering" "hub_to_data" {
  count = var.enable_hub_spoke_peering ? 1 : 0

  name                      = "peer-hub-to-data"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["data"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_peering.app_to_hub]
}

resource "azurerm_virtual_network_peering" "data_to_hub" {
  count = var.enable_hub_spoke_peering ? 1 : 0

  name                      = "peer-data-to-hub"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.this["data"].name
  remote_virtual_network_id = azurerm_virtual_network.this["hub"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_peering.hub_to_data]
}

resource "azurerm_virtual_network_peering" "hub_to_ops" {
  count = var.enable_hub_spoke_peering ? 1 : 0

  name                      = "peer-hub-to-ops"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.this["hub"].name
  remote_virtual_network_id = azurerm_virtual_network.this["ops"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_peering.data_to_hub]
}

resource "azurerm_virtual_network_peering" "ops_to_hub" {
  count = var.enable_hub_spoke_peering ? 1 : 0

  name                      = "peer-ops-to-hub"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.this["ops"].name
  remote_virtual_network_id = azurerm_virtual_network.this["hub"].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [azurerm_virtual_network_peering.hub_to_ops]
}
