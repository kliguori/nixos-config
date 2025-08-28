{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.glances.enable = true;

  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;
    allowedHosts = "mycroft:8082";

    customCSS = ''
      body, html {
        font-family: SF Pro Display, Helvetica, Arial, sans-serif !important;
      }
      .font-medium {
        font-weight: 700 !important;
      }
      .font-light {
        font-weight: 500 !important;
      }
      .font-thin {
        font-weight: 400 !important;
      }
      #information-widgets {
        padding-left: 1.5rem;
        padding-right: 1.5rem;
      }
      div#footer {
        display: none;
      }
      .services-group.basis-full.flex-1.px-1.-my-1 {
        padding-bottom: 3rem;
      };
    '';

    settings = {
      title = "Mycroft Dashboard";
      theme = "dark";
      layout = [
        {
          Glances = {
            header = false;
            style = "row";
            columns = 4;
          };
        }
        {
          Media = {
            header = true;
            style = "column";
          };
        }
        {
          Services = {
            header = true;
            style = "column";
          };
        }
      ];
    };

    services = [
      {
        "Glances" =
          let
            port = toString config.services.glances.port;
          in
          [
            {
              Info = {
                widget = {
                  type = "glances";
                  url = "http://localhost:${port}";
                  metric = "info";
                  chart = false;
                  version = 4;
                };
              };
            }
            {
              "CPU Temp" = {
                widget = {
                  type = "glances";
                  url = "http://localhost:${port}";
                  metric = "sensor:Package id 0";
                  chart = false;
                  version = 4;
                };
              };
            }
            {
              Processes = {
                widget = {
                  type = "glances";
                  url = "http://localhost:${port}";
                  metric = "process";
                  chart = false;
                  version = 4;
                };
              };
            }
            {
              Network = {
                widget = {
                  type = "glances";
                  url = "http://localhost:${port}";
                  metric = "network:enp57s0u1u4u3";
                  chart = false;
                  version = 4;
                };
              };
            }
          ];
      }
      {
        "Media" = [
          {
            "Jellyfin" = {
              href = "http://mycroft:8096";
              # icon = "jellyfin.png";
              description = "Jellyfin Media Server";
            };
          }
        ];
      }
      {
        "Services" = [
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
  };
}
