# Lab 01 — VNet, DNS, Peering, Routing and NAT

## Goal

Build the Azure networking foundation that every later cloud, security and architecture topic depends on.

## Mental model

```text
Internet
   │
Public IP / NAT
   │
VNet
├── Subnet A
├── Subnet B
│
├── Peering ─────► Other VNet
│
├── Route Table
│
└── DNS resolution
```

## You must understand

- address spaces and subnets
- system routes vs user-defined routes
- VNet peering and its non-transitive nature
- Azure-provided DNS vs custom DNS
- public IPs and outbound connectivity
- NAT Gateway purpose

## Hands-on

1. Create one resource group.
2. Create two VNets with non-overlapping CIDRs.
3. Create at least one subnet in each.
4. Peer the VNets in both directions.
5. Create a route table and associate it with one subnet.
6. Create a NAT Gateway and associate it with one subnet.
7. Create lightweight test endpoints only if needed to prove connectivity.

Prefer Azure CLI.

## Verify

Use a small set of checks:

```bash
az network vnet list -o table
az network vnet peering list --resource-group <rg> --vnet-name <vnet> -o table
az network route-table route list --resource-group <rg> --route-table-name <rt> -o table
az network nat gateway show --resource-group <rg> --name <nat>
```

If test hosts are deployed, prove connectivity and DNS resolution.

## Break / fix

Break the peering or associate an incorrect route, observe the failure, then restore the working state.

## Know before moving on

You should be able to explain:

- why overlapping VNet CIDRs are a problem
- why peering does not automatically create transitive routing
- how a UDR can override Azure system routing
- what NAT Gateway changes and what it does not change
- how DNS and routing solve different problems

## Skip / concept-only

Do not spend time on every public-IP SKU permutation or every NAT scaling detail. Learn those during exam revision if required.

## Cleanup

Delete the resource group unless you intentionally reuse it for the next lab.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/01-introduction-to-azure-virtual-networks
