# Lab 01 — Core VNets and Subnets

## Scenario

LIFELINE needs separate network boundaries for shared connectivity, applications, data and operations. At this stage the networks are intentionally **not connected**.

That matters: before learning how networks communicate, we first prove that separate VNets are separate routing domains.

## What this lab deploys

```text
Resource Group
  |
  +-- Hub VNet        10.0.0.0/16
  |    +-- snet-shared-services 10.0.4.0/24
  |
  +-- App Spoke       10.10.0.0/16
  |    +-- snet-web 10.10.1.0/24
  |    +-- snet-app 10.10.2.0/24
  |
  +-- Data Spoke      10.20.0.0/16
  |    +-- snet-data 10.20.1.0/24
  |    +-- snet-private-endpoints 10.20.10.0/24
  |
  +-- Operations      10.30.0.0/16
       +-- snet-management 10.30.1.0/24
       +-- snet-monitoring 10.30.2.0/24
```

No VNet peering is created yet.

## Deploy with Terraform

From PowerShell:

```powershell
az login
az account show --output table
$env:ARM_SUBSCRIPTION_ID = az account show --query id -o tsv

cd terraform
terraform init
terraform fmt -check
terraform validate
terraform plan -var-file="stages/01-core-network.tfvars" -out="stage01.tfplan"
terraform apply "stage01.tfplan"
```

## Verify with Azure CLI

```powershell
az network vnet list --resource-group rg-lifeline-lab-network-aue --output table

az network vnet subnet list `
  --resource-group rg-lifeline-lab-network-aue `
  --vnet-name vnet-lifeline-lab-app-aue `
  --output table
```

## Questions to answer

1. What is the difference between a VNet address space and a subnet prefix?
2. Why do the four VNets use non-overlapping `/16` ranges?
3. Why do we create only some of the reserved service subnets now?
4. Can the App Spoke reach the Data Spoke at this stage? Why?
5. What must we add in Lab 02 to create a direct Azure network relationship between the spokes and hub?

## Cleanup

If you are stopping after Lab 01:

```powershell
terraform destroy -var-file="stages/01-core-network.tfvars"
```

If continuing directly to Lab 02 later, retain the resources so the next stage can extend the same architecture.
