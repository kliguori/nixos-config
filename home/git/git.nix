{ config, lib, pkgs, ... }: 

{
  programs.git = {
    enable = true;
    userName = "MinimumAction";
    userEmail = "liguori.km@gmail.com";
    aliases = {};
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      color.ui = true;
    };
  };
}
