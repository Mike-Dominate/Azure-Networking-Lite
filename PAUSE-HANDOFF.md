# Project LIFELINE — Pause Handoff

## Pause point

Project LIFELINE is intentionally paused during Stage 05 so the Azure environment can be destroyed while AZ-700 theory is studied without ongoing cloud cost.

## Completed stages

- Stage 00 — Architecture, naming and IP plan — DONE
- Stage 01 — Core VNets and subnets — DONE
- Stage 02 — Hub-spoke peering — DONE
- Stage 03 — Routing, UDRs and transit intent — DONE
- Stage 04 — Hybrid VPN — DONE in cost-aware mixed mode

## Stage 05 status

Stage 05 — DNS and name resolution — IN PROGRESS.

Hands-on foundation completed and verified:
- Private DNS zone `lifeline.internal`
- Synthetic A record `api.lifeline.internal -> 10.10.2.10`
- Private DNS VNet links for Hub, App, Data and Ops
- Hub DNS resolver subnets:
  - `snet-dns-inbound` — `10.0.3.0/28`
  - `snet-dns-outbound` — `10.0.3.16/28`
- Both resolver subnets delegated to `Microsoft.Network/dnsResolvers`
- Terraform returned `No changes` after drift and peering regression fixes

Not yet completed:
- Plan-only validation of the cost-gated Azure DNS Private Resolver, inbound endpoint and outbound endpoint
- Stage 05 learning/troubleshooting exercises
- Stage 05 PR/merge

## Current branch

`lifeline-stage-05-dns`

The branch contains the cost-gated DNS Private Resolver resources in `terraform/dns-resolver.tf` with `enable_dns_private_resolver = false` by default.

## Azure cleanup

The Azure environment can be destroyed using the Stage 05 tfvars. The Terraform code and Git history remain available for a later rebuild.

From `terraform/`:

```powershell
terraform plan -destroy -var-file="stages/05-dns.tfvars" -out="lifeline-destroy.tfplan"
terraform apply "lifeline-destroy.tfplan"
```

Then verify the resource group no longer exists:

```powershell
az group exists --name rg-lifeline-lab-network-aue
```

Expected result: `false`.

## Resume point

When returning to hands-on work:

1. Checkout and update `lifeline-stage-05-dns`.
2. Rebuild the cumulative environment using:
   `terraform apply -var-file="stages/05-dns.tfvars"`
3. Confirm the post-apply plan is clean.
4. Continue with the plan-only DNS Private Resolver exercise:

```powershell
terraform plan `
  -var-file="stages/05-dns.tfvars" `
  -var="enable_dns_private_resolver=true"
```

Do not deploy billed resolver endpoints unless intentionally choosing a hands-on hybrid-DNS exercise.

## Theory phase

During the pause, study AZ-700 as architecture and troubleshooting scenarios rather than deploying resources. Use Project LIFELINE as the mental topology so routing, DNS, hybrid connectivity, load balancing, private access, security, resilience and diagnostics remain part of one coherent system.
