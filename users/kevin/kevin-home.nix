{ config, lib, pkgs, osConfig, ... }: 

{
  home = {
    username = "kevin";
    homeDirectory = "/home/kevin";
    stateVersion = "25.05";
    packages = with pkgs; [
      brave
      kitty
      mpv
      spotify
      tokyonight-gtk-theme
      virt-manager
      nil                                     # Nix Language server
      nixpkgs-fmt                             # Nix Formatter
      statix                                  # Nix Linter
      haskellPackages.haskell-language-server # Haskell Language Server
      haskellPackages.ormolu                  # Haskell Formatter
      haskellPackages.hlint                   # Haskell Linter                  
    ];
  };
  imports = [
    ../../home/ghostty/ghostty.nix    # Ghostty config
    ../../home/git/git.nix            # Git config
    ../../home/zsh/zsh.nix            # Zsh config
    ../../home/starship/starship.nix  # Starship config
    ../../home/neovim/neovim.nix      # Neovim config
    ../../home/vscode/vscode.nix      # VSCode config
  ] ++ lib.optionals (osConfig.desktopEnv == "hyprland") [
    ../../home/hyprland/hyprland.nix  # Wofi config
    ../../home/wofi/wofi.nix          # Wofi config
    ../../home/waybar/waybar.nix      # Waybar config
  ];
}
