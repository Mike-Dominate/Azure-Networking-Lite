# Lab 00 — Architecture and IP Plan

## Objective

Understand the LIFELINE end state before creating Azure resources.

## Mental model

A VNet address plan is an architectural dependency. If address spaces overlap or service subnets are not reserved, later peering, VPN and managed-service deployments can become unnecessarily difficult.

## Read

1. [`../../docs/architecture/END-STATE.md`](../../docs/architecture/END-STATE.md)
2. [`../../docs/architecture/IP-PLAN.md`](../../docs/architecture/IP-PLAN.md)

## Explain before continuing

Without notes, answer:

1. Why is the hub separate from the application, data and operations spokes?
2. Why must VNet address spaces not overlap?
3. Why are `GatewaySubnet`, `AzureFirewallSubnet` and application-delivery ranges reserved before their services exist?
4. Which network should eventually contain private endpoints?
5. Which network represents the external/on-premises environment in the hybrid lab?

## Deliverable

Lab 00 is complete when the address plan makes sense to you and you can redraw the top-level architecture from memory.

No Azure resources are deployed in this lab.
