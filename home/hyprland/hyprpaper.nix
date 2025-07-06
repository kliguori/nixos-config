{ config, lib, pkgs, ... }: 

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/kevin/Pictures/wallpaper/wallpaper.jpg"
      ];
      wallpaper = [
        "eDP-1,/home/kevin/Pictures/wallpaper/wallpaper.jpg"
      ];
    };
  };
}
