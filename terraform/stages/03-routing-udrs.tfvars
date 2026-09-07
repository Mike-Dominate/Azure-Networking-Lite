# Project LIFELINE — Stage 03
# Keep the Stage 02 hub/spoke peerings and add explicit spoke routing intent.

project_name             = "lifeline"
environment              = "lab"
primary_location         = "australiaeast"
secondary_location       = "southeastasia"
enable_secondary_region  = false
enable_hub_spoke_peering = true
enable_spoke_routing     = true
hub_transit_ip           = "10.0.4.4"

tags = {
  Purpose = "AZ-700-LIFELINE"
  Stage   = "03-routing-udrs"
}
