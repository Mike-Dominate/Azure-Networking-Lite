locals {
  name_prefix         = "${var.project_name}-${var.environment}"
  resource_group_name = "rg-${local.name_prefix}-network-aue"

  common_tags = merge(
    {
      Project     = "Project LIFELINE"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Learning    = "AZ-700"
    },
    var.tags
  )

  primary_vnets = {
    hub = {
      name          = "vnet-${local.name_prefix}-hub-aue"
      location      = var.primary_location
      address_space = ["10.0.0.0/16"]
    }
    app = {
      name          = "vnet-${local.name_prefix}-app-aue"
      location      = var.primary_location
      address_space = ["10.10.0.0/16"]
    }
    data = {
      name          = "vnet-${local.name_prefix}-data-aue"
      location      = var.primary_location
      address_space = ["10.20.0.0/16"]
    }
    ops = {
      name          = "vnet-${local.name_prefix}-ops-aue"
      location      = var.primary_location
      address_space = ["10.30.0.0/16"]
    }
  }

  hybrid_vnets = var.enable_hybrid_foundation ? {
    hq = {
      name          = "vnet-${local.name_prefix}-hq-aue"
      location      = var.primary_location
      address_space = [var.simulated_hq_address_space]
    }
  } : {}

  secondary_vnets = var.enable_secondary_region ? {
    app_sea = {
      name          = "vnet-${local.name_prefix}-app-sea"
      location      = var.secondary_location
      address_space = ["10.110.0.0/16"]
    }
  } : {}

  vnets = merge(local.primary_vnets, local.hybrid_vnets, local.secondary_vnets)

  primary_subnets = {
    hub_shared = {
      name             = "snet-shared-services"
      vnet_key         = "hub"
      address_prefixes = ["10.0.4.0/24"]
    }
    app_web = {
      name             = "snet-web"
      vnet_key         = "app"
      address_prefixes = ["10.10.1.0/24"]
    }
    app_backend = {
      name             = "snet-app"
      vnet_key         = "app"
      address_prefixes = ["10.10.2.0/24"]
    }
    data_workload = {
      name             = "snet-data"
      vnet_key         = "data"
      address_prefixes = ["10.20.1.0/24"]
    }
    data_private_endpoints = {
      name             = "snet-private-endpoints"
      vnet_key         = "data"
      address_prefixes = ["10.20.10.0/24"]
    }
    ops_management = {
      name             = "snet-management"
      vnet_key         = "ops"
      address_prefixes = ["10.30.1.0/24"]
    }
    ops_monitoring = {
      name             = "snet-monitoring"
      vnet_key         = "ops"
      address_prefixes = ["10.30.2.0/24"]
    }
  }

  hybrid_subnets = var.enable_hybrid_foundation ? {
    hub_gateway = {
      name             = "GatewaySubnet"
      vnet_key         = "hub"
      address_prefixes = ["10.0.1.0/27"]
    }
    hq_workload = {
      name             = "snet-hq"
      vnet_key         = "hq"
      address_prefixes = [var.simulated_hq_subnet_prefix]
    }
  } : {}

  dns_subnets = var.enable_dns_foundation ? {
    dns_inbound = {
      name               = "snet-dns-inbound"
      vnet_key           = "hub"
      address_prefixes   = ["10.0.3.0/28"]
      delegation_name    = "Microsoft.Network/dnsResolvers"
      delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
    dns_outbound = {
      name               = "snet-dns-outbound"
      vnet_key           = "hub"
      address_prefixes   = ["10.0.3.16/28"]
      delegation_name    = "Microsoft.Network/dnsResolvers"
      delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  } : {}

  secondary_subnets = var.enable_secondary_region ? {
    app_sea_web = {
      name             = "snet-web"
      vnet_key         = "app_sea"
      address_prefixes = ["10.110.1.0/24"]
    }
    app_sea_backend = {
      name             = "snet-app"
      vnet_key         = "app_sea"
      address_prefixes = ["10.110.2.0/24"]
    }
  } : {}

  subnets = merge(local.primary_subnets, local.hybrid_subnets, local.dns_subnets, local.secondary_subnets)
}
