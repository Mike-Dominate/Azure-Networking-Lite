# Project LIFELINE — Stage 02
# Keep the Stage 01 network boundaries and add bidirectional Hub/Spoke peerings.

project_name             = "lifeline"
environment              = "lab"
primary_location         = "australiaeast"
secondary_location       = "southeastasia"
enable_secondary_region  = false
enable_hub_spoke_peering = true

tags = {
  Purpose = "AZ-700-LIFELINE"
  Stage   = "02-hub-spoke-peering"
}
