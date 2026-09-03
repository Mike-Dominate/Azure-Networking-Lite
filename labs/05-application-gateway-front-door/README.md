# Lab 05 — Application Gateway and Front Door

## Goal

Understand Azure's Layer-7 application delivery options and when to use a regional reverse proxy versus a global edge service.

## Mental model

```text
Regional HTTP(S)
Client ──► Application Gateway/WAF ──► app backends

Global HTTP(S)
Client ──► Azure Front Door/WAF ──► preferred regional origin
```

## You must understand

- Layer 7 routing
- listener, backend pool, health probe and routing rule
- TLS termination / end-to-end TLS concepts
- WAF purpose
- Application Gateway is regional
- Front Door is global/edge based
- host/path routing
- origin health and failover

## Hands-on

1. Deploy a minimal Application Gateway with a lightweight backend if cost allows.
2. Configure one listener, backend and routing rule.
3. Verify HTTP(S) routing.
4. Create or inspect a Front Door profile and origin group.
5. Understand how Front Door chooses healthy origins.

Use one working path; do not build every routing pattern.

## Verify

```bash
az network application-gateway list -o table
az network application-gateway show-backend-health --resource-group <rg> --name <appgw>
az afd profile list -o table
az afd origin-group list --resource-group <rg> --profile-name <profile> -o table
```

Use `curl -I` against the public endpoint and inspect the response.

## Break / fix

Make one backend unhealthy or point a health probe at the wrong path. Observe the unhealthy state, then correct it.

## Know before moving on

Be able to explain:

- Application Gateway vs Load Balancer
- Front Door vs Traffic Manager
- regional vs global application delivery
- why health probes and TLS configuration matter
- what WAF adds

## Skip / concept-only

- every WAF policy setting
- advanced rewrite rules
- complex multi-site deployments
- every Front Door routing feature

## Cleanup

Delete cost-bearing Application Gateway resources promptly after validation.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/05-load-balance-http-traffic-in-azure
