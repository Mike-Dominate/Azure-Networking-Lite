# Lab 03 — Routing, UDRs and Transit Intent

## Scenario

LIFELINE now has a hub-and-spoke topology, but peering alone does not make the hub a transit router. The App, Data and Ops spokes each know how to reach the Hub directly, but Azure does not automatically forward traffic from one spoke through the Hub to another spoke.

Stage 03 introduces **user-defined routes (UDRs)** so you can separate three questions:

1. **Connectivity** — is there a network relationship?
2. **Routing** — where should the packet go next?
3. **Forwarding** — is there a device that will actually move the packet onward?

## Mental model

```text
Stage 02

APP <----> HUB <----> DATA
             ^
             |
             v
            OPS

Peerings exist, but the hub is not automatically a transit router.
```

Stage 03 adds route tables to the spokes:

```text
APP route table
10.20.0.0/16 -> VirtualAppliance 10.0.4.4
10.30.0.0/16 -> VirtualAppliance 10.0.4.4

DATA route table
10.10.0.0/16 -> VirtualAppliance 10.0.4.4
10.30.0.0/16 -> VirtualAppliance 10.0.4.4

OPS route table
10.10.0.0/16 -> VirtualAppliance 10.0.4.4
10.20.0.0/16 -> VirtualAppliance 10.0.4.4
```

`10.0.4.4` is deliberately reserved as a **future transit/NVA address** in the Hub. No forwarding appliance exists there yet.

That incompleteness is intentional.

The lesson is:

> A UDR can tell Azure where traffic should go next, but a route does not create the next-hop device.

## What this stage creates

- `rt-lifeline-lab-app-aue`
- `rt-lifeline-lab-data-aue`
- `rt-lifeline-lab-ops-aue`
- two spoke-to-spoke UDRs in each route table
- route-table associations for the existing App, Data and Ops subnets

No Azure Firewall or custom NVA is deployed in this stage.

## Why we are not deploying an NVA yet

Adding a firewall or Linux router now would blur two ideas together. First you should see that:

```text
Peering != transit
UDR != forwarding device
```

A later stage will introduce an actual transit component and the required `allow_forwarded_traffic` behavior.

## Deploy

From `terraform/`:

```powershell
terraform fmt -check -recursive
terraform validate
terraform plan -var-file="stages/03-routing-udrs.tfvars"
```

Review the plan before applying.

Expected new resources:

- 3 route tables
- 6 subnet/route-table associations

The route objects are embedded in the three route tables.

Then apply:

```powershell
terraform apply -var-file="stages/03-routing-udrs.tfvars"
```

## Validate with Azure CLI

List route tables:

```powershell
az network route-table list `
  --resource-group rg-lifeline-lab-network-aue `
  --output table
```

Inspect the App routes:

```powershell
az network route-table route list `
  --resource-group rg-lifeline-lab-network-aue `
  --route-table-name rt-lifeline-lab-app-aue `
  --output table
```

Inspect the Data routes:

```powershell
az network route-table route list `
  --resource-group rg-lifeline-lab-network-aue `
  --route-table-name rt-lifeline-lab-data-aue `
  --output table
```

Inspect the Ops routes:

```powershell
az network route-table route list `
  --resource-group rg-lifeline-lab-network-aue `
  --route-table-name rt-lifeline-lab-ops-aue `
  --output table
```

Confirm a subnet has the intended route table:

```powershell
az network vnet subnet show `
  --resource-group rg-lifeline-lab-network-aue `
  --vnet-name vnet-lifeline-lab-app-aue `
  --name snet-web `
  --query "{Subnet:name,RouteTable:routeTable.id}" `
  --output table
```

## Failure / reasoning exercise

Assume an App workload needs to reach Data.

The App subnet has this UDR:

```text
10.20.0.0/16 -> 10.0.4.4
```

Question: will that make App-to-Data traffic work?

**No.** The route specifies a next hop, but there is no forwarding device at `10.0.4.4` yet.

This is the deliberate incomplete design for Stage 03.

## What to be able to explain before moving on

1. Why does peering not make the hub transitive?
2. What does a route table change?
3. What is the difference between a route and a forwarding device?
4. Why is `VirtualAppliance` used as the next-hop type?
5. Why would `allow_forwarded_traffic` matter once a real NVA exists?
6. Why does longest-prefix match matter when multiple routes could apply?

## Cleanup

Do not destroy the environment after this lab. LIFELINE is cumulative; Stage 04 builds on the same infrastructure.
