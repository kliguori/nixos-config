{ config, lib, pkgs, ... }:

let 
  hp = pkgs.haskellPackages;
in {
  config = lib.mkIf (config.desktopEnv == "xmonad") {
    services.xserver = {
      enable = true;
      windowManager.xmonad.enable = true;
      displayManager.startx.enable = true;
    };

    environment.systemPackages = with pkgs; [
      hp.ghc
      hp.xmonad
      hp.xmonad-contrib
      xorg.xinit
      rofi
      ghostty
      xmobar
    ];
  };
}
