# Project LIFELINE — Azure Networking Lite

A focused, architecture-driven AZ-700 learning project built around one evolving system: a **Global Emergency Response Network**.

The goal is not to become a narrow networking specialist. The goal is to build durable skill in **networked, cloud and distributed systems** while covering the current AZ-700 domains: core networking, connectivity services, application delivery, private access and network security.

## Why LIFELINE exists

The original [`Mike-Dominate/Azure-Networking`](https://github.com/Mike-Dominate/Azure-Networking) remains the rigorous/deep-study track.

This repository is the focused track. Instead of unrelated labs, every stage changes the **same architecture** until it becomes a realistic multi-region Azure network.

```text
DESIGN
  ↓
DEPLOY
  ↓
VERIFY
  ↓
BREAK
  ↓
DIAGNOSE
  ↓
FIX
  ↓
EXPLAIN
  ↓
DESTROY / ADVANCE
```

## End state

Start with the editable architecture and IP plan:

- [`docs/architecture/END-STATE.md`](docs/architecture/END-STATE.md)
- [`docs/architecture/IP-PLAN.md`](docs/architecture/IP-PLAN.md)

The final system includes hub-and-spoke networking, controlled routing, hybrid connectivity, DNS, private access, load balancing, global application delivery, security controls and network observability.

## Lab roadmap

| Lab | LIFELINE capability | Mode |
|---:|---|---|
| 00 | Architecture, naming and IP plan | Design |
| 01 | Core VNets and subnets | Hands-on |
| 02 | Hub-spoke peering and reachability | Hands-on |
| 03 | Routing, UDRs and controlled egress | Hands-on |
| 04 | Hybrid VPN: point-to-site and site-to-site | Mixed |
| 05 | DNS and hybrid name resolution | Hands-on |
| 06 | Private Link and Private Endpoints | Hands-on |
| 07 | Regional load distribution | Hands-on |
| 08 | DNS-based regional failover with Traffic Manager | Hands-on |
| 09 | Layer-7 delivery with Application Gateway | Hands-on |
| 10 | Global HTTP delivery with Front Door | Hands-on |
| 11 | NSGs, ASGs, Firewall and WAF | Hands-on / cost-aware |
| 12 | Network Watcher, flow visibility and diagnostics | Hands-on |
| 13 | Failure injection and troubleshooting | Hands-on |
| 14 | ExpressRoute, Virtual WAN and Route Server | Design / simulate |
| 15 | Capstone: LIFELINE Failover Day | Hands-on |

Only Labs 00 and 01 are created initially. Later labs are added when we are ready to learn them; this prevents the repository becoming a wall of code you deploy without understanding.

## Terraform strategy

There is **one Terraform codebase** under [`terraform/`](terraform/). It grows with the architecture.

Early stages intentionally use visible AzureRM resources rather than hiding them behind custom modules. Once the networking concepts are understood, the capstone can refactor repeated patterns into modules.

Established version policy:

```hcl
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
```

## Start here

1. Read [`labs/00-architecture-ip-plan/README.md`](labs/00-architecture-ip-plan/README.md).
2. Review the end-state diagram and IP plan.
3. Continue to [`labs/01-core-network/README.md`](labs/01-core-network/README.md).
4. Deploy Stage 01 from Terraform.
5. Verify the VNets/subnets with Azure CLI.
6. Destroy Stage 01 if you are finished for the session, or keep it for the next stage.

## Guardrails

- Azure CLI is the primary verification interface.
- Portal use is allowed when it improves the mental model, not as the only method.
- Expensive services are enabled only for the lab that needs them and destroyed promptly.
- ExpressRoute-scale services are designed/simulated unless real deployment adds enough learning value to justify cost.
- Every hands-on lab includes at least one meaningful failure when useful.
- A lab is not complete until you can explain **where the component sits in the packet/request path and what breaks without it**.

## Preservation

The original Lite repository state from before LIFELINE is preserved on branch [`pre-lifeline`](https://github.com/Mike-Dominate/Azure-Networking-Lite/tree/pre-lifeline). See [`docs/MIGRATION.md`](docs/MIGRATION.md) for the mapping from the old eight-lab outline to LIFELINE.
