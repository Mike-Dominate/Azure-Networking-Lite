# Lab 06 — Network Security

## Goal

Understand the controls that restrict, inspect and steer Azure network traffic.

## Mental model

```text
Internet / on-prem
      │
      ▼
Azure Firewall / NVA
      │
      ▼
Route Table (UDR)
      │
      ▼
Subnet / NIC
      │
      ▼
NSG
      │
      ▼
Workload
```

## You must understand

- NSG rules, priorities and stateful behaviour
- subnet vs NIC association
- service tags and application security groups
- UDRs and forced tunnelling concepts
- Azure Firewall purpose
- network rules vs application rules at a high level
- Firewall Policy and centralised control
- DDoS protection concepts

## Hands-on

1. Create two subnets and test endpoints.
2. Apply an NSG that permits one flow and denies another.
3. Verify effective rules.
4. Create a route table and associate it with a subnet.
5. Inspect Azure Firewall architecture; deploy it only if cost is justified for the lab session.

## Verify

```bash
az network nsg list -o table
az network nsg rule list --resource-group <rg> --nsg-name <nsg> -o table
az network nic list-effective-nsg --resource-group <rg> --name <nic>
az network nic show-effective-route-table --resource-group <rg> --name <nic>
az network route-table route list --resource-group <rg> --route-table-name <rt> -o table
```

Use connectivity tests to prove which traffic is allowed and denied.

## Break / fix

Add a higher-priority deny rule or an incorrect UDR, observe the failure, identify the effective rule/route, then correct it.

## Know before moving on

Be able to explain:

- NSG vs Azure Firewall
- stateful filtering
- why rule priority matters
- why UDRs can create black holes
- subnet vs NIC enforcement
- when central inspection is desirable

## Skip / concept-only

- every Firewall SKU feature
- every threat-intelligence mode
- full enterprise secured-hub architecture
- exhaustive DDoS tuning

## Cleanup

Delete any Azure Firewall resources immediately after validation to avoid unnecessary cost.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/06-design-and-implement-network-security
