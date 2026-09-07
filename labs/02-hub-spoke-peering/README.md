# Lab 02 — Hub-and-Spoke VNet Peering

## Scenario

Stage 01 created four separate Azure VNets for Project LIFELINE. They share a resource group and region, but that does not create connectivity between them.

Stage 02 introduces the first deliberate private paths in the architecture: the Hub is peered with App, Data and Operations.

## Mental model

Before:

```text
HUB        APP        DATA        OPS
 |          |           |          |
isolated   isolated    isolated   isolated
```

After:

```text
                  HUB
              10.0.0.0/16
             /     |      \
            /      |       \
           /       |        \
         APP      DATA       OPS
      10.10/16   10.20/16   10.30/16
```

Azure represents each direction as its own peering resource:

```text
HUB  ─────► APP
HUB  ◄───── APP

HUB  ─────► DATA
HUB  ◄───── DATA

HUB  ─────► OPS
HUB  ◄───── OPS
```

Six peering resources therefore describe three bidirectional relationships.

## The critical AZ-700 concept: peering is not transitive

This topology gives App a direct path to Hub and Data a direct path to Hub. It does **not** automatically create an App-to-Data path through Hub.

```text
APP ─── HUB ─── DATA

APP → HUB   = direct peering
DATA → HUB  = direct peering
APP → DATA  = NOT automatically available through HUB
```

Later, Stage 03 will introduce explicit routing and a network virtual appliance/firewall pattern to make controlled spoke-to-spoke transit possible.

## What Terraform changes

Stage 02 retains every Stage 01 resource and enables six `azurerm_virtual_network_peering` resources:

- `hub_to_app`
- `app_to_hub`
- `hub_to_data`
- `data_to_hub`
- `hub_to_ops`
- `ops_to_hub`

For this stage:

- virtual-network access: enabled
- forwarded traffic: disabled
- gateway transit: disabled
- remote gateways: disabled

Those settings are intentional. We will change them only when a later architecture requirement gives us a reason.

## Deploy

From `terraform/`:

```powershell
terraform fmt -check -recursive
terraform validate
terraform plan -var-file="stages/02-hub-spoke-peering.tfvars"
```

Review the plan. You should see the six peering resources being added. Existing tagged resources can also receive the new Stage 02 tag value.

Then apply:

```powershell
terraform apply -var-file="stages/02-hub-spoke-peering.tfvars"
```

## Verify from Azure CLI

List peerings on the Hub:

```powershell
az network vnet peering list `
  --resource-group rg-lifeline-lab-network-aue `
  --vnet-name vnet-lifeline-lab-hub-aue `
  --query "[].{Name:name,State:peeringState,Remote:remoteVirtualNetwork.id}" `
  --output table
```

Expected Hub peerings:

```text
peer-hub-to-app
peer-hub-to-data
peer-hub-to-ops
```

Each should reach `Connected` once its reverse peering exists.

Check the reverse App peering:

```powershell
az network vnet peering list `
  --resource-group rg-lifeline-lab-network-aue `
  --vnet-name vnet-lifeline-lab-app-aue `
  --query "[].{Name:name,State:peeringState}" `
  --output table
```

Repeat for Data and Ops.

## Break / fix exercise — remove one direction

After the healthy topology is verified, intentionally remove only the App-to-Hub direction:

```powershell
az network vnet peering delete `
  --resource-group rg-lifeline-lab-network-aue `
  --vnet-name vnet-lifeline-lab-app-aue `
  --name peer-app-to-hub
```

Inspect the Hub/App peering states again. This demonstrates that a healthy bidirectional relationship depends on both directional resources.

Then let Terraform detect and repair the drift:

```powershell
terraform plan -var-file="stages/02-hub-spoke-peering.tfvars"
terraform apply -var-file="stages/02-hub-spoke-peering.tfvars"
```

Finally confirm idempotence:

```powershell
terraform plan -var-file="stages/02-hub-spoke-peering.tfvars"
```

Target result:

```text
No changes. Your infrastructure matches the configuration.
```

## Completion check

Explain these without notes:

1. Why did Stage 01 VNets not communicate just because they were in the same resource group?
2. Why do three bidirectional VNet relationships create six Terraform peering resources?
3. Why does App → Hub plus Hub → Data not automatically mean App → Data?
4. What is the difference between direct VNet access and forwarded traffic?
5. What did Terraform do when we deliberately deleted one Azure-managed peering outside Terraform?
