{
  pkgs,
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
      qbittorrent
    ];
  };
  imports = [
    ../../home/hyprland-watson/hyprland.nix # Hyprland config
    ../../home/wofi/wofi.nix # Wofi config
    ../../home/waybar/waybar.nix # Waybar config
    ../../home/ghostty/ghostty.nix # Ghostty config
    ../../home/zsh/zsh.nix # Zsh config
    ../../home/starship/starship.nix # Starship config
    ../../home/git/git.nix # Git config
    ../../home/neovim/neovim.nix # Neovim config
  ];
}
