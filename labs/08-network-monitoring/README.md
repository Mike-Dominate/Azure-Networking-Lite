# Lab 08 — Network Monitoring and Troubleshooting

## Goal

Build a repeatable troubleshooting method for Azure networking rather than memorising isolated tools.

## Mental model

```text
Symptom
  │
  ▼
DNS? ──► Route? ──► NSG/Firewall? ──► Service health? ──► Application?
  │           │             │               │
  └──── inspect with Network Watcher / effective routes / flow checks ────┘
```

## You must understand

- Network Watcher purpose
- Connection Monitor
- IP flow verify
- effective NSG rules
- effective routes
- next hop
- packet capture concept
- diagnostic settings and logs at a high level

## Hands-on

1. Reuse or create two simple test endpoints.
2. Create a working path between them.
3. Verify the path.
4. Introduce one routing or NSG fault.
5. Use Azure troubleshooting tools to identify the fault.
6. Fix it and prove recovery.

## Verify / troubleshoot

Useful Azure CLI patterns include:

```bash
az network watcher test-ip-flow ...
az network watcher show-next-hop ...
az network nic list-effective-nsg ...
az network nic show-effective-route-table ...
az network watcher connection-monitor list ...
```

Exact parameters depend on the resources used in the lab; use `az <command> -h` rather than memorising every flag.

## Troubleshooting order

Use this order unless evidence tells you otherwise:

1. **Name resolution** — does the hostname resolve to the expected address?
2. **Route** — where will Azure send the packet?
3. **Security** — do NSG/firewall rules allow the flow?
4. **Health** — is the target/backend considered healthy?
5. **Application** — is the service actually listening/responding?

## Break / fix

This entire lab is break/fix. Create one fault yourself and diagnose it without immediately looking at the configuration you changed.

## Know before finishing the track

Be able to explain which tool you would use when:

- a VM cannot reach another VM
- a private endpoint resolves publicly
- a backend is marked unhealthy
- a route appears to go somewhere unexpected
- an NSG may be blocking a flow

## Skip / concept-only

Do not build an enterprise monitoring platform. Full Log Analytics/SIEM engineering belongs in later operations/security work.

## Cleanup

Delete all temporary resources.

## Deep dive

Full programme: https://github.com/Mike-Dominate/Azure-Networking/tree/main/modules/08-design-and-implement-network-monitoring
