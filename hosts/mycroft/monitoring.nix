{ config, lib, pkgs, ... }:

{
  #### Prometheus ####
  services.prometheus = {
    enable = true;

    # Bind to all interfaces so you can reach it over tailscale0.
    listenAddress = "0.0.0.0";
    port = 9090;

    # Keep 30 days of metrics
    retentionTime = "30d";
    
    # Scrape Prometheus itself + node exporter (host metrics).
    scrapeConfigs = [
      {
        job_name = "prometheus";
        static_configs = [ { targets = [ "127.0.0.1:9090" ]; } ];
      }
      {
        job_name = "node";
        static_configs = [ { targets = [ "127.0.0.1:9100" ]; } ];
      }
    ];
  };

  # Node exporter for system metrics
  services.prometheus.exporters.node = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 9100;
    enabledCollectors = [
      "systemd" "processes" "cpu" "meminfo" "filesystem" "netdev" "diskstats"
    ];
  };

  #### Grafana ####
  services.grafana = {
    enable = true;

    # Bind to all interfaces so you can reach it over tailscale0.
    settings.server = {
      http_addr = "0.0.0.0";
      http_port = 3000;
    };

    # Quick start credentials (replace with adminPasswordFile via sops-nix later!)
    security = {
      adminUser = "admin";
      adminPassword = "bobsyouruncle";
    };

    # Pre-provision Prometheus datasource so Grafana works out of the box
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://127.0.0.1:9090";
          isDefault = true;
        }
      ];
    };
  };
}
