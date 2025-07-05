{ config, lib, pkgs, ... }: {
  imports = [
    ../../modules/desktop-environments/hyprland.nix
  ];
}