# Stage 03: Routing intent and user-defined routes
#
# WHAT: Create one route table per spoke and add explicit routes for the other
#       spoke prefixes through a reserved hub transit IP.
# WHY:  Peering creates direct relationships, but it does not make the hub a
#       transitive router. UDRs let us express where traffic should go next.
# WHAT BREAKS WITHOUT IT: Spoke-to-spoke traffic has no explicit next-hop design.
# IMPORTANT: 10.0.4.4 is intentionally only a reserved future NVA address at
#            this stage. No appliance is listening there yet. The point of this
#            stage is to separate route intent from an actually functioning
#            forwarding device.

resource "azurerm_route_table" "app" {
  count = var.enable_spoke_routing ? 1 : 0

  name                = "rt-${local.name_prefix}-app-aue"
  location            = var.primary_location
  resource_group_name = azurerm_resource_group.network.name
  tags                = local.common_tags

  route {
    name                   = "to-data-via-hub"
    address_prefix         = "10.20.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_transit_ip
  }

  route {
    name                   = "to-ops-via-hub"
    address_prefix         = "10.30.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_transit_ip
  }
}

resource "azurerm_route_table" "data" {
  count = var.enable_spoke_routing ? 1 : 0

  name                = "rt-${local.name_prefix}-data-aue"
  location            = var.primary_location
  resource_group_name = azurerm_resource_group.network.name
  tags                = local.common_tags

  route {
    name                   = "to-app-via-hub"
    address_prefix         = "10.10.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_transit_ip
  }

  route {
    name                   = "to-ops-via-hub"
    address_prefix         = "10.30.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_transit_ip
  }
}

resource "azurerm_route_table" "ops" {
  count = var.enable_spoke_routing ? 1 : 0

  name                = "rt-${local.name_prefix}-ops-aue"
  location            = var.primary_location
  resource_group_name = azurerm_resource_group.network.name
  tags                = local.common_tags

  route {
    name                   = "to-app-via-hub"
    address_prefix         = "10.10.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_transit_ip
  }

  route {
    name                   = "to-data-via-hub"
    address_prefix         = "10.20.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.hub_transit_ip
  }
}

resource "azurerm_subnet_route_table_association" "app_web" {
  count = var.enable_spoke_routing ? 1 : 0

  subnet_id      = azurerm_subnet.this["app_web"].id
  route_table_id = azurerm_route_table.app[0].id
}

resource "azurerm_subnet_route_table_association" "app_backend" {
  count = var.enable_spoke_routing ? 1 : 0

  subnet_id      = azurerm_subnet.this["app_backend"].id
  route_table_id = azurerm_route_table.app[0].id
}

resource "azurerm_subnet_route_table_association" "data_workload" {
  count = var.enable_spoke_routing ? 1 : 0

  subnet_id      = azurerm_subnet.this["data_workload"].id
  route_table_id = azurerm_route_table.data[0].id
}

resource "azurerm_subnet_route_table_association" "data_private_endpoints" {
  count = var.enable_spoke_routing ? 1 : 0

  subnet_id      = azurerm_subnet.this["data_private_endpoints"].id
  route_table_id = azurerm_route_table.data[0].id
}

resource "azurerm_subnet_route_table_association" "ops_management" {
  count = var.enable_spoke_routing ? 1 : 0

  subnet_id      = azurerm_subnet.this["ops_management"].id
  route_table_id = azurerm_route_table.ops[0].id
}

resource "azurerm_subnet_route_table_association" "ops_monitoring" {
  count = var.enable_spoke_routing ? 1 : 0

  subnet_id      = azurerm_subnet.this["ops_monitoring"].id
  route_table_id = azurerm_route_table.ops[0].id
}
