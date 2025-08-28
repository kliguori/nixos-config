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

  # Function to make list of strings "monitor,wallpaperPath" for each monitor in monitors
  mkWallpaperList = monitors: path: builtins.map (m: "${m},${path}") monitors;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaperPath ];
      wallpaper = mkWallpaperList monitors wallpaperPath;
    };
  };
}
