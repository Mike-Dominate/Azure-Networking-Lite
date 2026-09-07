# Terraform stages

Each `.tfvars` file represents a learning checkpoint in the same LIFELINE architecture.

Only Stage 01 exists initially. New stage files are added when the Terraform code for that capability is introduced.

Planned sequence:

```text
01 core network
02 hub-spoke peering
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
15 final deployable capstone
```

The purpose of stages is not to create separate infrastructures. They make the architecture grow in controlled steps while retaining one Terraform codebase.
