{ config, lib, pkgs, ... }:

{
  options.fonts = {
    mono = lib.mkOption {
      type = lib.types.str;
      description = "Monospace font";
      default = "JetBrainsMono Nerd Font";
    };

    ui = lib.mkOption {
      type = lib.types.str;
      description = "UI font for menus and text";
      default = "JetBrainsMono Nerd Font";
    };

    size = lib.mkOption {
      type = lib.types.int;
      description = "Base font size in px";
      default = 16;
    };
  };

  config = {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}

