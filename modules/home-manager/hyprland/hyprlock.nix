{ config, lib, pkgs, ... }: {
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
          monitor = "eDP-1";
          path = "/home/kevin/Pictures/wallpaper/wallpaper.jpg";
        }
      ];

      input-field = [
        {
          size = "250, 50";
          outline_thickness = 3;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = "Password...";
          monitor = "eDP-1";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
