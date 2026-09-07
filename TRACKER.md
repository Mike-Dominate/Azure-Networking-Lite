# Project LIFELINE — Progress Tracker

The tracker measures capability, not ceremony.

| Lab | Capability | Status | One-sentence takeaway |
|---:|---|---|---|
| 00 | Architecture, naming, IP plan | DONE | One coherent address plan prevents later routing and service-subnet conflicts. |
| 01 | Core VNets and subnets | DONE | Separate VNets are separate routing domains; sharing a subscription, region or resource group does not connect them. |
| 02 | Hub-spoke peering | DONE | Peering creates direct VNet relationships, but it is not transitive and does not make the hub a transit router. |
| 03 | Routing, UDRs, egress | DONE | A UDR expresses route intent; a real forwarding device is still required to carry transit traffic to the next network. |
| 04 | Hybrid VPN | NOT STARTED | |
| 05 | DNS and name resolution | NOT STARTED | |
| 06 | Private Link / Private Endpoints | NOT STARTED | |
| 07 | Regional load distribution | NOT STARTED | |
| 08 | Traffic Manager | NOT STARTED | |
| 09 | Application Gateway | NOT STARTED | |
| 10 | Front Door | NOT STARTED | |
| 11 | Network security controls | NOT STARTED | |
| 12 | Monitoring and diagnostics | NOT STARTED | |
| 13 | Failure injection / troubleshooting | NOT STARTED | |
| 14 | ExpressRoute / vWAN / Route Server | NOT STARTED | |
| 15 | Capstone failover day | NOT STARTED | |

## Allowed status values

- `NOT STARTED`
- `IN PROGRESS`
- `DONE`
- `DESIGN ONLY`

## Completion rule

A hands-on lab is `DONE` only when you can:

1. explain the problem the component solves;
2. place it in the packet/request path;
3. deploy the minimum useful implementation;
4. verify it using CLI/network tools;
5. diagnose at least one meaningful failure when applicable; and
6. explain what would break if the component were removed or misconfigured.
