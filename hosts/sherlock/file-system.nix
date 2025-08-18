{ config, lib, pkgs, ... }: 

{
  # Swap devices
  swapDevices = [ ];

  # Root filesystem
  fileSystems."/" = { 
    device = "rpool/root";
    fsType = "zfs";
  };

  # Nix store filesystem
  fileSystems."/nix" = { 
    device = "rpool/nix";
    fsType = "zfs";
  };

  # Persistent storage filesystem
  fileSystems."/persist" = { 
    device = "rpool/persist";
    fsType = "zfs";
  };

  # Boot filesystem
  fileSystems."/boot" = { 
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # Persist NetworkManager connections by bind-mounting to /persist
  fileSystems."/etc/NetworkManager/system-connections" = {
    device = "/persist/etc/NetworkManager/system-connections";
    options = [ "bind" ];
  };

  # Persist Tailscale state by bind-mounting to /persist
  fileSystems."/var/lib/tailscale" = {
    device = "/persist/var/lib/tailscale";
    options = [ "bind" ];
  };

  # Persist SSH keys by bind-mounting to /persist
  fileSystems."/home/kevin/.ssh" = {
    device = "/persist/home/kevin/.ssh";
    options = [ "bind" ];
  };
}