{ config, lib, pkgs, osConfig, ... }:

let
  c = osConfig.theme.colors;
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_status$character";
      nix_shell = {
        format = "($name) ";
        style = "bold yellow";
      };
      character = {
        success_symbol = "[❯](bold ${c.green})";
        error_symbol = "[❯](bold ${c.red})";
        vicmd_symbol = "[❮](bold ${c.pink})";
      };
      directory.style = "bold ${c.cyan}";
      git_branch.style = "bold ${c.purple}";
      git_status.style = "bold ${c.orange}";
    };
  };
}
