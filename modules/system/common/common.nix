{ config, lib, pkgs, ... }: {

  # Basic settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   # Enable flakes
  nixpkgs.config.allowUnfree = true;                                 # Allow unfree software
  networking.firewall.enable = true;                                 # Turn on firewall
  nix.gc = {                                                         # Garbage collection
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  time.timeZone = "America/New_York";                                # Time zone and locale
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

  # Basic services
  services = {
    tailscale.enable = true;      # Enable  tailscale
    pulseaudio.enable = false;    # Disable pulseaudio
    pipewire = {                  # Enable  pipewire  
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Basic programs
  programs.zsh.enable = true;     # Enable zsh shell

  # Enable virtualization
  virtualisation = {
    docker.enable = true;              # Enable docker
    libvirtd = {                       # Enable QEMU and KVM
        enable = true;
        qemu.package = pkgs.qemu_kvm;
    };
  };

  # Basic (CLI) packages
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
    rsync
    zfs
    parted
    util-linux     # Provides mount, umount, lsblk, blkid, etc.

    # Version control & symlinking
    git
    stow
  ];

}