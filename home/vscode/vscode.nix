{ config, lib, pkgs, osConfig, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      haskell.haskell
      bbenoist.nix
    ];

    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "editor.formatOnSave" = true;
      "files.insertFinalNewline" = true;
    };
  };
}
