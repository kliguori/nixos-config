{ config, lib, pkgs, ... }:

{
    programs.hyprland.enable = false;
    programs.uwsm.enable = false;
    programs.waybar.enable = false;


  services = {
      xserver = {
        enable = true;
        displayManager.lightdm.enable = true;
        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
      displayManager.defaultSession = "none+xmonad";
    };

    environment.systemPackages = with pkgs; [
      haskellPackages.ghc
      haskellPackages.xmonad
      haskellPackages.xmonad-contrib
      rofi
      ghostty
      xmobar
    ];
}
