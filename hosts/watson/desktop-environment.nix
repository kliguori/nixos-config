{ config, lib, pkgs, ... }:

let
  desktopModules = {
    hyprland = ../../system/desktop-environments/hyprland.nix;
  };
  selectedDE = config.desktopEnv;
  selectedModule = builtins.getAttr selectedDE desktopModules;
in {
  imports = lib.mkIf (builtins.hasAttr selectedDE desktopModules) [
    (import selectedModule)
  ];
}