{ config, lib, pkgs, osConfig, ... }: 

{
  home = {
    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "25.05";
    packages = with pkgs; [
      brave
      #ghostty
      kitty
      mpv
      spotify
      tokyonight-gtk-theme
      virt-manager
      vscode
      haskell-language-server
      hlint
      ormolu
    ];
  };
  imports = [
    ../../home/ghostty/ghostty.nix    # Ghostty config
    ../../home/git/git.nix            # Git config
    ../../home/zsh/zsh.nix            # Zsh config
    ../../home/starship/starship.nix  # Starship config
    ../../home/neovim/neovim.nix      # Neovim config
  ] ++ lib.optionals (osConfig.desktopEnv == "hyprland") [
    ../../home/hyprland/hyprland.nix  # Wofi config
    ../../home/wofi/wofi.nix          # Wofi config
    ../../home/waybar/waybar.nix      # Waybar config
  ];
}