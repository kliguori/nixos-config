{
  ...
}:

{
  # Zram swap 
  swapDevices = [ ];
  zramSwap = {
    enable = true;
    memoryPercent = 25;
    algorithm = "zstd";
  };

 # ---------------------------------------------
  # Directories to bind mount to /etc
  # ---------------------------------------------
  # network connections
  fileSystems."/etc/NetworkManager/system-connections" = {
    device = "/persist/etc/NetworkManager/system-connections";
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

}
