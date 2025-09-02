{
  ...
}:
let
  monitors = [
    "eDP-1"
  ];
  wallpaperPath = "/home/kevin/wallpapers/notre-dame.jpg";

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
