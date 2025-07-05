{ config, lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Kevin Liguori";
    userEmail = "kevin@example.com";
    aliases = {};
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      color.ui = true;
    };
  };
}
