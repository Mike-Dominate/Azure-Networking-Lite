# Azure Networking Lite

A fast, hands-on Azure networking competency track derived from the full [`Mike-Dominate/Azure-Networking`](https://github.com/Mike-Dominate/Azure-Networking) programme.

## Why this repository exists

The full repository is intentionally rigorous: it follows the AZ-700 curriculum in detail, uses a cumulative BlueHarbor architecture, retains Terraform state, performs deliberate failure testing, and produces extensive evidence and programme documentation.

**Azure-Networking-Lite has a different objective:** acquire the networking knowledge that compounds into AZ-104, AZ-305, AZ-400, SC-500 and cloud/AI architecture work without turning AZ-700 into a long specialist detour.

This repository does **not** replace or modify the original repository. The original remains the deep-study track.

## Lite working method

Every hands-on lab follows this loop:

```text
UNDERSTAND
    ↓
DEPLOY
    ↓
VERIFY
    ↓
BREAK / FIX (one meaningful failure when useful)
    ↓
5-MINUTE NOTES
    ↓
DESTROY
    ↓
NEXT
```

### Deliberately removed

- exhaustive evidence packs
- screenshots of routine portal steps
- full rebuild PDFs for every lab
- Terraform conversion for every exercise
- multiple deployment methods for the same concept
- persistent cross-module infrastructure/state
- extensive Git checkpoints
- obscure edge cases unless they teach a transferable principle
- exam trivia as a substitute for understanding

### Still required

- a clear mental model
- one real deployment where practical
- Azure CLI as the preferred execution/verification interface
- meaningful validation (`az`, `nslookup`, `curl`, Network Watcher, route checks, etc.)
- one useful break/fix exercise where it materially improves understanding
- resource cleanup after the lab

## Lab map

| Lab | Competency | Mode | Priority |
|---:|---|---|---|
| 01 | VNet fundamentals, DNS, peering, routing, NAT | Hands-on | **CORE** |
| 02 | VPN Gateway, S2S/P2S, Virtual WAN | Mixed | **CORE concepts** |
| 03 | ExpressRoute architecture and routing | Design / concept | **CORE concepts** |
| 04 | Azure Load Balancer and Traffic Manager | Hands-on | **CORE** |
| 05 | Application Gateway and Front Door | Hands-on | **CORE** |
| 06 | NSGs, Azure Firewall, routing/security controls | Hands-on | **CORE** |
| 07 | Private Link, Private Endpoints and Private DNS | Hands-on | **CORE+** |
| 08 | Network Watcher, Connection Monitor and troubleshooting | Hands-on | **CORE** |

Start at [`labs/01-vnet-dns-peering-routing-nat/README.md`](labs/01-vnet-dns-peering-routing-nat/README.md).

## Depth rule

Use the Lite lab first. If a concept is unclear, important to your job, or genuinely interesting, follow the **Deep Dive** link in that lab back to the corresponding module in the original Azure-Networking repository.

## Certification strategy

This track is designed to produce **networking competence, not mandatory AZ-700 certification**. After completing it, the intended high-ROI progression is:

```text
AZ-104 → AZ-305 → AZ-400 → SC-500 → SC-100 → AI-103 → AI-300
```

AZ-700 remains optional. Sit it if the marginal exam-prep effort is small or if Azure networking becomes a deliberate specialization.

## Completion standard

A lab is complete when you can answer these five questions without notes:

1. What problem does this service solve?
2. Where does it sit in the packet/request path?
3. What are the two or three configuration choices that matter most?
4. How do I verify that it is working?
5. What does a common failure look like and where would I troubleshoot first?

If you can answer those and successfully complete the practical validation, move on.
