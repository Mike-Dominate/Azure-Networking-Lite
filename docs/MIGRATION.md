# Migration from Azure Networking Lite to Project LIFELINE

## Preservation point

The complete pre-LIFELINE repository is preserved on branch [`pre-lifeline`](https://github.com/Mike-Dominate/Azure-Networking-Lite/tree/pre-lifeline) at commit `84f27d221cb0782dbb158c5ad54742d06060601c`.

No Terraform state or implementation code was lost during the restructure because the previous Lite repository contained only the root documentation and eight lab README files.

## Why the structure changed

The old repository grouped AZ-700 topics into eight independent labs. LIFELINE turns those topics into stages of one evolving architecture so every new concept has a dependency and a reason to exist.

## Old-to-new mapping

| Previous Lite area | LIFELINE destination |
|---|---|
| 01 VNet, DNS, peering, routing, NAT | Labs 00, 01, 02, 03 and 05 |
| 02 Hybrid networking | Lab 04 |
| 03 ExpressRoute | Lab 14 |
| 04 Load Balancer + Traffic Manager | Labs 07 and 08 |
| 05 Application Gateway + Front Door | Labs 09 and 10 |
| 06 Network security | Lab 11 |
| 07 Private access | Lab 06 |
| 08 Monitoring + troubleshooting | Labs 12 and 13 |

## Working principle

Future changes should preserve one rule: **do not create a new stand-alone lab when the concept can be expressed as the next change to the LIFELINE architecture.**
