{ config, lib, pkgs, ...}:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Dracula";
      font-size = 12;
      mouse-hide-while-typing = true;
      window-decoration = true;
      background-opacity = 0.75;
    };
  };
}