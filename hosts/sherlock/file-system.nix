{ config, lib, pkgs, ... }: 

{
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

  # Bind-mount persistent directories
  # fileSystems."/etc/NetworkManager/system-connections" = {
  #   device = "/persist/etc/NetworkManager/system-connections";
  #   options = [ "bind" ];
  # };

  swapDevices = [ ];
}