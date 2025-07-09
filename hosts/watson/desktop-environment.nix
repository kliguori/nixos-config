{ config, lib, pkgs, ... }:

{
  imports = [
    ../../system/desktop-environments/hyprland.nix
    ../../system/desktop-environments/xmonad.nix
  ];
}