{ config, lib, pkgs, ... }: {
  imports = [
    ../../modules/system/desktop-environments/hyprland.nix
  ];
}