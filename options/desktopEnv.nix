{ config, lib, pkgs, ... }: 

{
  options.desktopEnv = lib.mkOption {
    type = lib.types.str;
    default = "none";
    description = "The desktop environment in use (e.g. hyprland, gnome, etc.)";
  };
}