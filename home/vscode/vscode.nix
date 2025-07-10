{ config, lib, pkgs, osConfig, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        haskell.haskell
        justusadam.language-haskell # required for haskell language server
        bbenoist.nix
      ];
      userSettings = {
        "workbench.colorTheme" = "Dracula";
        "editor.formatOnSave" = true;
        "files.insertFinalNewline" = true;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";
      };
    };
  };
}
