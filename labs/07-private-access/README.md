# Lab 07 — Private Access to Azure Services

## Goal

Understand how Azure PaaS services are consumed privately from VNets using Private Link, Private Endpoints and Private DNS.

## Mental model

```text
Workload in VNet
      │
      ▼
Private DNS resolves service name
      │
      ▼
Private Endpoint (private IP in subnet)
      │
      ▼
Azure PaaS service
```

## You must understand

- Private Link vs Private Endpoint
- private endpoint NIC/IP placement
- private DNS zones and VNet links
- public access can remain enabled or be disabled separately
- service endpoints vs private endpoints at a high level
- why DNS is often the hidden dependency

## Hands-on

1. Create a VNet and subnet.
2. Create a low-cost supported PaaS service such as Storage.
3. Create a Private Endpoint.
4. Create/link the appropriate Private DNS zone.
5. Verify the service FQDN resolves to the private IP from inside the VNet.
6. If practical, disable public network access and confirm the private path still works.

## Verify

```bash
az network private-endpoint list -o table
az network private-endpoint show --resource-group <rg> --name <pe>
az network private-dns zone list -o table
az network private-dns link vnet list --resource-group <rg> --zone-name <zone> -o table
nslookup <service-fqdn>
```

Use `curl`, storage tooling or the relevant client to prove data-plane access.

## Break / fix

Remove or unlink the Private DNS zone, observe name-resolution behaviour, then restore the link. This is one of the most transferable troubleshooting exercises in the track.

## Know before moving on

Be able to explain:

- why a Private Endpoint gives a PaaS service a private IP presence in your VNet
- why Private DNS matters
- Private Endpoint vs service endpoint
- why private connectivity does not automatically mean public access is disabled
- where NSGs, routing and DNS can affect the private path

## Priority

**CORE+**. Spend more attention here than on many specialist AZ-700 topics because Private Link appears repeatedly in architecture, security, data and AI platform designs.

## Cleanup

Delete the resource group after validation.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/07-design-and-implement-private-access-to-azure-services
