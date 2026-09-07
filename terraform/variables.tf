variable "project_name" {
  description = "Short project identifier used in Azure resource names."
  type        = string
  default     = "lifeline"
}

variable "environment" {
  description = "Environment identifier used in Azure resource names."
  type        = string
  default     = "lab"
}

variable "primary_location" {
  description = "Primary Azure region."
  type        = string
  default     = "australiaeast"
}

variable "secondary_location" {
  description = "Secondary Azure region used by later resilience labs."
  type        = string
  default     = "southeastasia"
}

variable "enable_secondary_region" {
  description = "Create the secondary application VNet. Later stages turn this on when regional failover is introduced."
  type        = bool
  default     = false
}

variable "enable_hub_spoke_peering" {
  description = "Create bidirectional hub-to-spoke peerings for the App, Data and Operations VNets."
  type        = bool
  default     = false
}

variable "enable_spoke_routing" {
  description = "Create spoke route tables and UDRs that point spoke-to-spoke prefixes toward the reserved hub transit IP."
  type        = bool
  default     = false
}

variable "hub_transit_ip" {
  description = "Reserved future network virtual appliance IP in the hub. Stage 03 uses it to show that UDR intent is not the same as a functioning transit device."
  type        = string
  default     = "10.0.4.4"
}

variable "tags" {
  description = "Additional tags applied to LIFELINE resources."
  type        = map(string)
  default     = {}
}
