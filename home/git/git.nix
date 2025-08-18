{ config, lib, pkgs, ... }: 

{
  programs.git = {
    enable = true;
    userName = "kliguori";
    userEmail = "liguori.km@gmail.com";
    aliases = {};
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      color.ui = true;
    };
  };
}
