# Project LIFELINE — Stage 04
# Build the hybrid-connectivity foundation but keep the hourly-billed VPN Gateway off by default.

project_name               = "lifeline"
environment                = "lab"
primary_location           = "australiaeast"
secondary_location         = "southeastasia"
enable_secondary_region    = false
enable_hub_spoke_peering   = true
enable_spoke_routing       = true
hub_transit_ip             = "10.0.4.4"
enable_hybrid_foundation   = true
enable_vpn_gateway         = false
simulated_hq_address_space = "172.16.0.0/16"
simulated_hq_subnet_prefix = "172.16.1.0/24"
vpn_gateway_sku            = "VpnGw1AZ"

tags = {
  Purpose = "AZ-700-LIFELINE"
  Stage   = "04-hybrid-vpn"
}
