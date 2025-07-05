{ config, lib, pkgs, ... }:
  
let
  f = config.fonts;
  c = config.theme.colors;
in {
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "tray" "pulseaudio" "battery" "clock" ];

      clock = {
        format = "<span foreground='#f5c2e7'>   </span>{:%a %d %H:%M}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span size='13000' foreground='#a6e3a1'>{icon} </span> {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        tooltip-format = "{time}";
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "";
        format-icons.default = [ "" "" " " ];
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "<span size='13000' foreground='#f5e0dc'>  </span>{essid}";
        format-disconnected = "<span size='13000' foreground='#f5e0dc'>  </span>Disconnected";
      };
    }];

    style = ''
      * {
        font-family: "${f.mono}";
        font-size: ${toString f.size}px;
        font-weight: bold;
        color: ${c.foreground};
        background: ${c.background};
      }

      window#waybar {
        background-color: ${c.background};
        color: ${c.foreground};
        border-bottom: 1px solid ${c.comment};
      }

      #clock {
        color: ${c.pink};
        border-bottom: 2px solid ${c.pink};
      }

      #pulseaudio {
        color: ${c.cyan};
        border-bottom: 2px solid ${c.cyan};
      }

      #battery {
        color: ${c.green};
        border-bottom: 2px solid ${c.green};
      }

      #network {
        color: ${c.yellow};
        border-bottom: 2px solid ${c.yellow};
      }
    '';
  };
}
  