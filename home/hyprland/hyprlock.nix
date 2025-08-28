{
  config,
  lib,
  pkgs,
  ...
}:

let
  monitors = [
    "HDMI-A-1"
    "HDMI-A-2"
  ];
  wallpaperPath = "/home/kevin/wallpapers/kyoto-night.png";

  # Function to make background for each montor
  mkBackground =
    monitors: wallpaperPath:
    builtins.map (m: {
      monitor = m;
      path = wallpaperPath;
    }) monitors;
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = false;
        no_fade_in = false;
        grace = 0;
        hide_cursor = true;
      };

      background = mkBackground monitors wallpaperPath;

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
