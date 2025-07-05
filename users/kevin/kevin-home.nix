{ config, lib, pkgs, ... }: {
  home = {
    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "25.05";
    packages = with pkgs; [
      brave
      ghostty
      kitty
      mpv
      spotify
      tokyonight-gtk-theme
      virt-manager
      vscode
    ];
  };
  imports = [
    ../../modules/themes/dracula.nix                  # Dracula theme
    ../../modules/fonts/nerd-font.nix                 # JetbrainsMono Nerd Font
    ../../modules/home-manager/hyprland/hypr.nix      # hyprland config
    ../../modules/home-manager/waybar/waybar.nix      # Waybar theme
    ../../modules/home-manager/wofi/wofi.nix          # Wofi theme
    ../../modules/home-manager/git/git.nix            # Git config
    ../../modules/home-manager/zsh/zsh.nix            # Zsh config
    ../../modules/home-manager/starship/starship.nix  # Starship config
  ];
}