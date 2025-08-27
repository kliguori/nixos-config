{ config, lib, pkgs, ... }: 

let
  monitors = [ 
    "HDMI-A-1" 
    "HDMI-A-2" 
  ];
  wallpaperPath = "/persist/home/kevin/wallpapers/kyoto-night.jpg";
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = false;
        no_fade_in = false;
        grace = 0;
        hide_cursor = true;
      };

      background = [
        {
          monitor = monitors;
          path = wallpaperPath;
        }
      ];

      input-field = [
        {
          size = "250, 50";
          outline_thickness = 3;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = "Password...";
          monitor = monitors;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
