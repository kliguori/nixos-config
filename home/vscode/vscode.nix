{ config, lib, pkgs, osConfig, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode; 
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      haskell.haskell
    ];
  };

  userSettings = {
    "workbench.colorTheme" = "Dracula";
    "editor.formatOnSave" = true;
    "haskell.formattingProvider" = "ormolu";
    "files.insertFinalNewline" = true;
  };
}