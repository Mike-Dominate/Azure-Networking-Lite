# Project LIFELINE — Stage 05
# Keep the existing hub/spoke, routing and hybrid foundation, then add private DNS.

project_name             = "lifeline"
environment              = "lab"
primary_location         = "australiaeast"
secondary_location       = "southeastasia"
enable_secondary_region  = false
enable_hub_spoke_peering = true
enable_spoke_routing     = true
hub_transit_ip           = "10.0.4.4"
enable_hybrid_foundation = true
enable_vpn_gateway       = false

enable_dns_foundation    = true
private_dns_zone_name     = "lifeline.internal"
dns_synthetic_record_name = "api"
dns_synthetic_record_ip   = "10.10.2.10"
enable_dns_private_resolver = false

tags = {
  Purpose = "AZ-700-LIFELINE"
  Stage   = "05-dns"
}
