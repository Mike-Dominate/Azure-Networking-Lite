# Project LIFELINE — IP Address Plan

The plan reserves room for future services before we deploy them. Address spaces do not overlap.

## Azure VNets

| Network | Region | Address space | Purpose |
|---|---|---:|---|
| Hub VNet | Australia East | `10.0.0.0/16` | Shared connectivity, VPN, firewall, DNS and management services |
| App Spoke | Australia East | `10.10.0.0/16` | Primary application workloads |
| Data Spoke | Australia East | `10.20.0.0/16` | Data services and private endpoints |
| Operations Spoke | Australia East | `10.30.0.0/16` | Monitoring and management workloads |
| Secondary App Spoke | Secondary region | `10.110.0.0/16` | Regional application failover |
| Simulated HQ | Australia East (lab simulation) | `172.16.0.0/16` | Represents an on-premises network for hybrid connectivity labs |

## Hub reservations

| CIDR | Planned use |
|---:|---|
| `10.0.0.0/26` | `AzureFirewallSubnet` |
| `10.0.1.0/27` | `GatewaySubnet` |
| `10.0.2.0/26` | `AzureBastionSubnet` if we decide it adds value |
| `10.0.3.0/28` | DNS Private Resolver inbound endpoint |
| `10.0.3.16/28` | DNS Private Resolver outbound endpoint |
| `10.0.4.0/24` | Shared services |

Only `10.0.4.0/24` is created in Lab 01. Service-specific hub subnets are created when their corresponding service is introduced.

## Primary App Spoke

| CIDR | Subnet | Purpose |
|---:|---|---|
| `10.10.1.0/24` | `snet-web` | Front-end/application instances |
| `10.10.2.0/24` | `snet-app` | API/backend workloads |
| `10.10.10.0/24` | reserved | Application Gateway subnet, created later |

## Data Spoke

| CIDR | Subnet | Purpose |
|---:|---|---|
| `10.20.1.0/24` | `snet-data` | Data-processing/test workloads |
| `10.20.10.0/24` | `snet-private-endpoints` | Private Endpoint NICs |

## Operations Spoke

| CIDR | Subnet | Purpose |
|---:|---|---|
| `10.30.1.0/24` | `snet-management` | Management/test hosts |
| `10.30.2.0/24` | `snet-monitoring` | Monitoring/diagnostic workloads when needed |

## Secondary App Spoke

| CIDR | Subnet | Purpose |
|---:|---|---|
| `10.110.1.0/24` | `snet-web` | Secondary regional web/application tier |
| `10.110.2.0/24` | `snet-app` | Secondary regional backend tier |
| `10.110.10.0/24` | reserved | Secondary Application Gateway subnet |

## Why these ranges matter

A network design is easier to evolve when service-specific ranges are reserved before deployment. Later labs can add gateways, firewalls, DNS resolvers and application-delivery services without renumbering existing workloads.
