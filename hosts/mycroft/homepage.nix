{ config, lib, pkgs, ... }:

{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;
    allowedHosts = "mycroft:8082";

    # Declarative config (Nix writes YAML into /etc/homepage-dashboard)
    settings = {
      title = "Mycroft Dashboard";
      theme = "dark";
    };

    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              href = "http://mycroft.8096";
              # icon = "jellyfin.png";
              description = "Jellyfin Media Server";
            };
          }
        ];
      }
      {
        "Smart Home" = [
          {
            "Home Assistant" = {
              href = "http://mycroft:8123";
              # icon = "home-assistant.png";
              description = "Home Assistant";
            };
          }
        ];
      }
    ];

    widgets = [
      { resources = { cpu = true; memory = true; disk = "/"; }; }
    ];
  };
}
