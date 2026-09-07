# Stage 05: DNS and hybrid name-resolution foundation
#
# WHAT: Create a private DNS namespace, link it to the Azure VNets, and add a
#       deliberately synthetic A record.
# WHY:  DNS answers "what address should I try?" while routing answers "how do I
#       get there?". Keeping those concerns separate makes later Private Link and
#       hybrid-DNS troubleshooting much easier.
# IMPORTANT: The synthetic record resolves to an intentionally unused IP. A
#            successful DNS lookup therefore does NOT prove application reachability.

resource "azurerm_private_dns_zone" "lifeline" {
  count = var.enable_dns_foundation ? 1 : 0

  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.network.name
  tags                = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  count = var.enable_dns_foundation ? 1 : 0

  name                  = "link-hub"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.lifeline[0].name
  virtual_network_id    = azurerm_virtual_network.this["hub"].id
  registration_enabled  = false
  tags                  = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "app" {
  count = var.enable_dns_foundation ? 1 : 0

  name                  = "link-app"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.lifeline[0].name
  virtual_network_id    = azurerm_virtual_network.this["app"].id
  registration_enabled  = false
  tags                  = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "data" {
  count = var.enable_dns_foundation ? 1 : 0

  name                  = "link-data"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.lifeline[0].name
  virtual_network_id    = azurerm_virtual_network.this["data"].id
  registration_enabled  = false
  tags                  = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "ops" {
  count = var.enable_dns_foundation ? 1 : 0

  name                  = "link-ops"
  resource_group_name   = azurerm_resource_group.network.name
  private_dns_zone_name = azurerm_private_dns_zone.lifeline[0].name
  virtual_network_id    = azurerm_virtual_network.this["ops"].id
  registration_enabled  = false
  tags                  = local.common_tags
}

resource "azurerm_private_dns_a_record" "synthetic_api" {
  count = var.enable_dns_foundation ? 1 : 0

  name                = var.dns_synthetic_record_name
  zone_name           = azurerm_private_dns_zone.lifeline[0].name
  resource_group_name = azurerm_resource_group.network.name
  ttl                 = 30
  records             = [var.dns_synthetic_record_ip]
  tags                = local.common_tags
}
