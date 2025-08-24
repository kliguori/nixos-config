{ config, lib, pkgs, ... }: 

{
  # No swap devices
  swapDevices = [ ];

  # ---------------------------------------------
  # Boot partition
  # /boot
  # ---------------------------------------------
  fileSystems."/boot" = { 
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  # ---------------------------------------------
  # Mountpoints for rpool datasets
  # ---------------------------------------------
  # root dataset
  fileSystems."/" = { 
    device = "rpool/root";
    fsType = "zfs";
  };

  # nix dataset
  fileSystems."/nix" = { 
    device = "rpool/nix";
    fsType = "zfs";
  };

  # persist dataset
  fileSystems."/persist" = { 
    device = "rpool/persist";
    fsType = "zfs";
  };

  # ---------------------------------------------
  # Mountpoints for dpool datasets
  # ---------------------------------------------
  # vmachines dataset
  fileSystems."/vmachines" = { 
    device = "dpool/crypt/vmachines";
    fsType = "zfs";
  };

  # ubuntu-dev dataset
  fileSystems."/vmachines/ubuntu-dev" = { 
    device = "dpool/crypt/vmachines/ubuntu-dev";
    fsType = "zfs";
  };

  # the-ripper dataset
  fileSystems."/vmachines/the-ripper" = { 
    device = "dpool/crypt/vmachines/the-ripper";
    fsType = "zfs";
  };

  # ---------------------------------------------
  # Directories to bind mount to /etc
  # ---------------------------------------------
  # network connections
  fileSystems."/etc/NetworkManager/system-connections" = {
    device = "/persist/etc/NetworkManager/system-connections";
    options = [ "bind" ];
  };

  # libvirt networks and config
  fileSystems."/etc/libvirt" = {
    device = "/persist/etc/libvirt";
    options = [ "bind" ];
  };

  # ---------------------------------------------
  # Directories to bind mount to /var/lib
  # ---------------------------------------------
  # tailscale state
  fileSystems."/var/lib/tailscale" = {
    device = "/persist/var/lib/tailscale";
    options = [ "bind" ];
  };

  # libvirt state
  fileSystems."/var/lib/libvirt" = {
    device = "/persist/var/lib/libvirt";
    options = [ "bind" ];
  };

  # ---------------------------------------------
  # Directories to bind mount to /home
  # ---------------------------------------------
  # ssh keys
  fileSystems."/home/kevin/.ssh" = {
    device = "/persist/home/kevin/.ssh";
    options = [ "bind" ];
  };

}
