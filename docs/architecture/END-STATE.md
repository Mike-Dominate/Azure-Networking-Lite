# Project LIFELINE — End-State Architecture

This is the target mental model. We will not deploy all of it at once.

```mermaid
flowchart TB
    public[Public users] --> internet[Internet / HTTPS]
    field[Field engineers] --> p2s[P2S VPN]
    hq[Simulated HQ / on-premises] --> s2s[S2S IPsec VPN]

    internet --> fd[Azure Front Door + WAF]
    fd --> appgw1[Application Gateway - Australia East]
    fd --> appgw2[Application Gateway - Secondary Region]

    tm[Traffic Manager - DNS failover] -. DNS answer .-> appgw1
    tm -. DNS answer .-> appgw2

    subgraph Azure[Microsoft Azure]
      subgraph Primary[Primary region - Australia East]
        appgw1 --> app1[App Spoke]
        app1 --> lb1[Regional Load Balancer]
      end

      subgraph Secondary[Secondary region]
        appgw2 --> app2[Secondary App Spoke]
        app2 --> lb2[Regional Load Balancer]
      end

      subgraph Hub[Hub VNet]
        vpn[VPN Gateway]
        fw[Azure Firewall]
        dns[DNS Private Resolver]
        shared[Shared services]
      end

      subgraph Data[Data Spoke]
        pe[Private Endpoints]
        stores[Storage / SQL / Key Vault]
        pe --> stores
      end

      subgraph Ops[Operations Spoke]
        monitor[Azure Monitor / Network Watcher]
        mgmt[Management tools]
      end

      app1 <--> Hub
      app2 <--> Hub
      Data <--> Hub
      Ops <--> Hub
      p2s --> vpn
      s2s --> vpn
      fw --> Data
      dns --> pe
    end

    nat[NAT Gateway / controlled egress] --> internet
    Hub --> nat
```

## The question this diagram should answer

At the end of the project you should be able to explain the complete path for a request such as:

```text
User
  -> DNS / global endpoint decision
  -> Front Door or Traffic Manager
  -> regional application delivery
  -> application subnet
  -> routing / security controls
  -> private DNS resolution
  -> Private Endpoint
  -> Azure data service
```

Then you should be able to explain what changes when a region, route, DNS record, VPN tunnel, health probe or security rule fails.

## Design principles

1. **Segmentation:** application, data, operations and shared connectivity have distinct network boundaries.
2. **Centralised connectivity:** the hub hosts shared networking/security services.
3. **Private data access:** platform data services are reached with private endpoints rather than public exposure.
4. **Multiple traffic layers:** DNS routing, Layer 4 load balancing and Layer 7 application delivery solve different problems.
5. **Failure is part of the design:** every major path must be observable and diagnosable.
6. **Cost awareness:** expensive services are deployed only when their lab needs them.
