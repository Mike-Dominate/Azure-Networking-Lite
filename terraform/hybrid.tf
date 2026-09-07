# Stage 04: Hybrid connectivity foundation
#
# WHAT: Add the dedicated GatewaySubnet and simulated HQ network through locals,
#       then optionally create a real Azure VPN Gateway.
# WHY:  Hybrid connectivity joins an external network or individual remote client
#       to Azure through a gateway; it is not VNet peering.
# COST: The VPN Gateway is hourly billed. It is disabled by default and should be
#       enabled only when the lab intentionally exercises the real service.

resource "azurerm_public_ip" "vpn_gateway" {
  count = var.enable_vpn_gateway ? 1 : 0

  name                = "pip-${local.name_prefix}-vpngw-aue"
  location            = var.primary_location
  resource_group_name = azurerm_resource_group.network.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = local.common_tags
}

resource "azurerm_virtual_network_gateway" "hub" {
  count = var.enable_vpn_gateway ? 1 : 0

  name                = "vng-${local.name_prefix}-hub-aue"
  location            = var.primary_location
  resource_group_name = azurerm_resource_group.network.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = var.vpn_gateway_sku

  active_active = false
  bgp_enabled   = false

  ip_configuration {
    name                          = "vng-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_gateway[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.this["hub_gateway"].id
  }

  tags = local.common_tags

  lifecycle {
    precondition {
      condition     = var.enable_hybrid_foundation
      error_message = "enable_hybrid_foundation must be true before enabling the VPN Gateway."
    }
  }
}
