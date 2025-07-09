{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.desktopEnv == "xmonad") {
    services.xserver = {
      enable = true;
      windowManager.xmonad.enable = true;
      displayManager.startx.enable = true;
    };

    environment.systemPackages = with pkgs; [
      haskellPackages.ghc
      haskellPackages.xmonad
      haskellPackages.xmonad-contrib
      pkgs.xorg.xinit
      rofi
      ghostty
      xmobar
    ];
  };
}
