# Terraform stages

Each `.tfvars` file represents a learning checkpoint in the same LIFELINE architecture.

Implemented stages:

```text
01 core network
02 hub-spoke peering
```

Planned sequence:

```text
03 routing and egress
04 hybrid VPN
05 DNS
06 private access
07 regional load distribution
08 Traffic Manager
09 Application Gateway
10 Front Door
11 security controls
12 monitoring
13 failure injection
14 ExpressRoute / vWAN / Route Server design
15 final deployable capstone
```

The purpose of stages is not to create separate infrastructures. They make the architecture grow in controlled steps while retaining one Terraform codebase.

Use the matching stage file for both `plan` and `apply`. For example:

```powershell
terraform plan  -var-file="stages/02-hub-spoke-peering.tfvars"
terraform apply -var-file="stages/02-hub-spoke-peering.tfvars"
```
