# Project LIFELINE — Stage 01
# Core VNets and workload subnets only. No peering exists yet.

project_name            = "lifeline"
environment             = "lab"
primary_location        = "australiaeast"
secondary_location      = "southeastasia"
enable_secondary_region = false

tags = {
  Purpose = "AZ-700-LIFELINE"
  Stage   = "01-core-network"
}
