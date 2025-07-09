{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.desktopEnv == "xmonad") {
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

      services.picom = {
        enable = true;
        settings = {
          vsync = true;
          backend = "glx";
        };
      };

      environment.systemPackages = with pkgs; [
        haskellPackages.ghc
        haskellPackages.xmonad
        haskellPackages.xmonad-contrib
        rofi
        ghostty
        xmobar
      ];
  };
}
