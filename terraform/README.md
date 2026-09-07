# LIFELINE Terraform

This directory contains the single Terraform configuration that grows with Project LIFELINE.

## Version policy

- Terraform: `>= 1.6.0`
- AzureRM provider: `~> 4.0`

The project deliberately remains on AzureRM 4.x for consistency with the earlier labs. A provider-major upgrade should be a deliberate project change, not an incidental learning distraction.

## Authentication

Use Azure CLI authentication and explicitly expose the selected subscription to Terraform:

```powershell
az login
az account set --subscription "<subscription-name-or-id>"
$env:ARM_SUBSCRIPTION_ID = az account show --query id -o tsv
```

Do not commit credentials, secrets or local `terraform.tfvars` files.

## Stage 01

```powershell
terraform init
terraform fmt -check
terraform validate
terraform plan -var-file="stages/01-core-network.tfvars" -out="stage01.tfplan"
terraform apply "stage01.tfplan"
```

To destroy:

```powershell
terraform destroy -var-file="stages/01-core-network.tfvars"
```

## Why there are no custom modules yet

At this learning stage, the Azure resources should remain visible. Hiding everything behind a module would make it easier to deploy but harder to learn.

Once the architecture is understood and repetition appears, a later lab will refactor appropriate pieces into reusable modules. That exercise will teach Terraform abstraction at the right time.
