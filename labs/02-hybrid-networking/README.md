# Lab 02 — Hybrid Networking

## Goal

Understand how Azure connects to users, branches and on-premises networks without turning this into a long VPN-specialist build.

## Mental model

```text
User ── P2S VPN ──► Azure VPN Gateway ◄── S2S VPN ── On-prem / branch
                           │
                           ▼
                         VNet

Multiple branches / hubs
        │
        ▼
   Azure Virtual WAN
```

## You must understand

- VPN Gateway purpose and GatewaySubnet
- Site-to-Site vs Point-to-Site
- local network gateway concept
- active-active / resiliency at a high level
- BGP purpose at a conceptual level
- Azure Virtual WAN and secured virtual hub mental model

## Hands-on

Deploy **one** VPN Gateway architecture if subscription cost/quota is reasonable. If not, build the VNet + GatewaySubnet and inspect the remaining configuration as concept-only.

Recommended minimum practical:

1. Create VNet and `GatewaySubnet`.
2. Create the required public IP.
3. Create or inspect a route-based VPN Gateway configuration.
4. Inspect how a local network gateway and connection would attach.
5. Review P2S address pool and authentication options.

## Verify

```bash
az network vnet subnet show --resource-group <rg> --vnet-name <vnet> --name GatewaySubnet
az network vnet-gateway show --resource-group <rg> --name <gateway>
az network local-gateway list --resource-group <rg> -o table
```

## Break / fix

If you deploy a full connection, deliberately mismatch one connection parameter or route and observe the connection state, then restore it. Otherwise skip break/fix for cost efficiency.

## Know before moving on

Be able to explain:

- why a VPN Gateway needs a dedicated GatewaySubnet
- when to choose S2S vs P2S
- what BGP adds over static routes
- why Virtual WAN exists
- where VPN fits relative to ExpressRoute

## Concept-only / safe to skip hands-on

- full multi-branch Virtual WAN build
- NVA integration in a virtual hub
- every authentication variant
- every gateway SKU

## Cleanup

Delete cost-bearing gateways promptly after validation.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/02-design-and-implement-hybrid-networking
