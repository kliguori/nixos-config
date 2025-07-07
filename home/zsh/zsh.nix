{ config, lib, pkgs, osConfig, ... }:

let
  c = osConfig.theme.colors;
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
      cl = "clear";
      rebuild = "sudo nixos-rebuild switch --flake .#$(hostname)";
      ocaml-dev = "nix develop $HOME/nixos-config#ocaml-dev";
    };
  };
}
