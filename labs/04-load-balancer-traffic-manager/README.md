# Lab 04 — Load Balancer and Traffic Manager

## Goal

Understand the difference between regional Layer-4 load balancing and DNS-based global endpoint selection.

## Mental model

```text
Regional traffic
Client ──► Azure Load Balancer ──► backend instances

Global DNS choice
Client ──DNS query──► Traffic Manager
                         │
                         └── returns preferred endpoint
```

## You must understand

- Azure Load Balancer is Layer 4 (TCP/UDP)
- frontend IP, backend pool, health probe and rule
- public vs internal Load Balancer
- Traffic Manager is DNS-based and not in the data path
- Traffic Manager routing methods at a high level
- DNS TTL and endpoint health implications

## Hands-on

1. Deploy a small Azure Load Balancer scenario with lightweight backends.
2. Configure one health probe and one load-balancing rule.
3. Verify traffic reaches healthy backends.
4. Configure a Traffic Manager profile with two endpoints if practical.
5. Resolve the Traffic Manager DNS name and inspect which endpoint is returned.

Prefer the cheapest practical backends; Azure Container Instances or small VMs are fine depending on quota.

## Verify

```bash
az network lb list -o table
az network lb probe list --resource-group <rg> --lb-name <lb> -o table
az network lb rule list --resource-group <rg> --lb-name <lb> -o table
az network traffic-manager profile list -o table
az network traffic-manager endpoint list --resource-group <rg> --profile-name <profile> --type azureEndpoints -o table
nslookup <traffic-manager-name>
```

## Break / fix

Stop or remove one backend/endpoint and observe health/failover behaviour. Restore it and verify recovery.

## Know before moving on

Be able to explain:

- Load Balancer vs Traffic Manager
- data-plane load balancing vs DNS decision-making
- why health probes matter
- what TTL affects
- why Traffic Manager cannot inspect HTTP paths

## Skip / concept-only

Do not implement every Traffic Manager routing mode. Understand Priority, Weighted, Performance, Geographic and MultiValue conceptually.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/04-load-balance-non-http-traffic-in-azure
