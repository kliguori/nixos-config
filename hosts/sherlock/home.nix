{ config, lib, pkgs, osConfig, ... }: 

{
  home = 
  let
    ocamlPkgs = pkgs.ocamlPackages;
  in {
    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "25.05";
    packages = (with pkgs; [
      brave
      kitty
      mpv
      obsidian
      nil                                     # Nix Language server
      nixpkgs-fmt                             # Nix Formatter
      statix                                  # Nix Linter   
      black                                   # Python Formatter
      ruff                                    # Python Linter
      pyright                                 # Python language server
      qbittorrent
    ]) ++ 
    (with ocamlPkgs; [
      ocaml-lsp
      ocamlformat
      merlin
    ]);
  };
  imports = [
    ../../home/hyprland/hyprland.nix  # Hyprland config
    ../../home/wofi/wofi.nix          # Wofi config
    ../../home/waybar/waybar.nix      # Waybar config
    ../../home/ghostty/ghostty.nix    # Ghostty config
    ../../home/zsh/zsh.nix            # Zsh config
    ../../home/starship/starship.nix  # Starship config
    ../../home/git/git.nix            # Git config
    ../../home/vscode/vscode.nix      # VSCode config
  ];
}
