{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  home = {
    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "25.05";
    packages = with pkgs; [
      brave
      kitty
      mpv
      obsidian
      spotify
      virt-manager
      nil # Nix Language server
      nixpkgs-fmt # Nix Formatter
      statix # Nix Linter
      black # Python Formatter
      ruff # Python Linter
      pyright # Python language server
    ];
  };
  imports =
    [
      ../../home/ghostty/ghostty.nix # Ghostty config
      ../../home/git/git.nix # Git config
      ../../home/zsh/zsh.nix # Zsh config
      ../../home/starship/starship.nix # Starship config
      ../../home/neovim/neovim.nix # Neovim config
      ../../home/vscode/vscode.nix # VSCode config
    ]
    ++ lib.optionals (osConfig.desktopEnv == "hyprland") [
      ../../home/hyprland/hyprland.nix # Wofi config
      ../../home/wofi/wofi.nix # Wofi config
      ../../home/waybar/waybar.nix # Waybar config
    ];
}
