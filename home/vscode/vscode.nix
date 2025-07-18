{ config, lib, pkgs, osConfig, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        ms-python.python        # Python support
        ms-pyright.pyright      # Pyright LSP
        bbenoist.nix
      ];
      userSettings = {
        "workbench.colorTheme" = "Dracula";
        
        "python.languageServer" = "Default";  
        "python.formatting.provider" = "black";
        "python.linting.enabled" = true;
        "python.linting.ruffEnabled" = true;  # needs ruff
        "python.linting.flake8Enabled" = false;
        "python.analysis.typeCheckingMode" = "strict";  # or "basic"
        
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";

        "editor.formatOnSave" = true;
        "files.insertFinalNewline" = true;
      };
    };
  };
}
