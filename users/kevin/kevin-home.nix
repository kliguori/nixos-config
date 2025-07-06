{ config, lib, osConfig, pkgs, ... }: 

{
  programs.home-manager.enable = true;
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
    ../../themes/colors/dracula.nix   # Dracula theme
    ../../themes/fonts/nerd-font.nix  # JetbrainsMono Nerd Font
    ../../home/waybar/waybar.nix      # Waybar theme
    ../../home/wofi/wofi.nix          # Wofi theme
    ../../home/git/git.nix            # Git config
    ../../home/zsh/zsh.nix            # Zsh config
    ../../home/starship/starship.nix  # Starship config
  ] ++ lib.optionals (osConfig.desktopEnv == "hyprland") [
    ../../home/hyprland/hyprland.nix  # hyprland config
  ];
}