# Lab 03 — ExpressRoute

## Goal

Understand ExpressRoute well enough for architecture, security and hybrid-cloud decisions without trying to reproduce a carrier-grade environment.

## Mental model

```text
On-premises / datacenter
        │
Connectivity provider
        │
ExpressRoute circuit
        │
Private peering + BGP
        │
ExpressRoute Gateway
        │
       VNet
```

## You must understand

- what ExpressRoute is and is not
- circuit, peering and gateway roles
- private peering
- BGP relationship
- resiliency concepts
- FastPath at a high level
- Global Reach at a high level
- when ExpressRoute is preferred over VPN

## Hands-on

**Concept-first.** Do not purchase or provision real carrier connectivity purely for this track.

Recommended practical:

1. Inspect ExpressRoute circuit and gateway resource models in Azure CLI/portal.
2. Build the VNet and `GatewaySubnet` pattern used by an ExpressRoute gateway if useful.
3. Review a sample circuit configuration and identify provider, peering location, bandwidth and SKU choices.
4. Trace the expected route path from on-premises to an Azure workload.

## Verify

If you have access to an existing ExpressRoute environment, inspect it with:

```bash
az network express-route list -o table
az network express-route show --resource-group <rg> --name <circuit>
az network express-route peering list --resource-group <rg> --circuit-name <circuit> -o table
az network vnet-gateway list --resource-group <rg> -o table
```

Otherwise validation is architectural: draw the path and correctly identify where BGP, the circuit and the VNet gateway participate.

## Break / fix

Concept-only: reason through what happens if BGP routes disappear, a circuit/provider path fails, or the VNet gateway is unavailable.

## Know before moving on

Be able to explain:

- ExpressRoute vs S2S VPN
- why BGP matters
- circuit vs gateway
- why redundant provider paths matter
- what FastPath changes
- what Global Reach enables

## Safe to skip hands-on

- provisioning a real ExpressRoute circuit for study
- Global Reach deployment
- FastPath deployment
- provider-specific configuration

## Cleanup

Delete any temporary gateway resources you created for inspection.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/03-design-and-implement-azure-expressroute
