{ config, lib, pkgs, modulesPath, ... }: 

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware.nix         # Include hardware configuration
    ./boot.nix             # Include boot configuration
    ./users.nix            # Include user configuration
    ./file-system.nix      # Include file system configuration
    ./systemd.nix          # Include systemd configuration 
    ./networking.nix       # Include networking configuration
    ./services.nix         # Include services configuration
    ./virtualisation.nix   # Include virtualisation configuration
    ./dracula.nix          # Include Dracula theme configuration
  ];

  # DO NOT CHANGE
  system.stateVersion = "25.05";

  # Nixpkgs settings
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;   # Allow unfree software
  };
  
  # Nix settings
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes
    gc = {                                                         # Garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Time and locale settings
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # System programs
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    zsh.enable = true;   # Enable zsh shell
    uwsm.enable = true;
    thunar.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Shell utilities
    coreutils
    findutils
    gnugrep
    gnused
    gawk
    less
    which
    file
    tree
    diffutils
    man
    pciutils
    unzip

    # Editors
    vim
    neovim
    nano

    # Networking
    curl
    wget
    dnsutils       # Provides dig, nslookup
    inetutils      # Provides host, etc.
    iproute2
    iputils
    nettools       # Provides ifconfig, netstat, etc.
    nmap
    traceroute

    # Monitoring
    htop
    btop
    fastfetch
    strace
    lsof
    tmux
    ripgrep
    fd
    bat
    duf
    ncdu

    # Storage & filesystem tools
    cryptsetup
    rsync
    zfs
    parted
    util-linux     # Provides mount, umount, lsblk, blkid, etc.

    # Version control & symlinking
    git
    stow

    # Virtualisation
    libvirt
    virt-manager
    qemu

    # Transcoding
    handbrake

    # Hyprland related packages
    brightnessctl
    hypridle
    hyprlock
    hyprpaper
    libnotify
    mako
    networkmanagerapplet
    pavucontrol
    waybar
    wlogout
    wofi
  ];

}
