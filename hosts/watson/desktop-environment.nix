{ config, lib, pkgs, ... }: 

{
  imports = [] ++ lib.optionals (config.desktopEnv == "hyprland") [
    ../../system/desktop-environments/hyprland.nix                  # Import hyprland module
  ];
}