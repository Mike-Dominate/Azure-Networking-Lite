# Stage 05: Cost-gated Azure DNS Private Resolver
#
# WHAT: Define the managed DNS Private Resolver and its inbound/outbound endpoints.
# WHY:  Inbound endpoints let external/on-premises DNS forward private-zone queries
#       into Azure. Outbound endpoints provide the egress path used by forwarding
#       rulesets when Azure must resolve external/on-premises namespaces.
# COST: Resolver endpoints are billed, so this block remains disabled by default.
#       Stage 05 plan-validates the design without leaving the service running.

resource "azurerm_private_dns_resolver" "hub" {
  count = var.enable_dns_private_resolver ? 1 : 0

  name                = "dnspr-${local.name_prefix}-hub-aue"
  resource_group_name = azurerm_resource_group.network.name
  location            = var.primary_location
  virtual_network_id  = azurerm_virtual_network.this["hub"].id
  tags                = local.common_tags

  lifecycle {
    precondition {
      condition     = var.enable_dns_foundation
      error_message = "enable_dns_foundation must be true before enabling Azure DNS Private Resolver."
    }
  }
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "hub" {
  count = var.enable_dns_private_resolver ? 1 : 0

  name                    = "inbound-${local.name_prefix}-aue"
  private_dns_resolver_id = azurerm_private_dns_resolver.hub[0].id
  location                = var.primary_location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.this["dns_inbound"].id
  }

  tags = local.common_tags
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "hub" {
  count = var.enable_dns_private_resolver ? 1 : 0

  name                    = "outbound-${local.name_prefix}-aue"
  private_dns_resolver_id = azurerm_private_dns_resolver.hub[0].id
  location                = var.primary_location
  subnet_id               = azurerm_subnet.this["dns_outbound"].id
  tags                    = local.common_tags
}
