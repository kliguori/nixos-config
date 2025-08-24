{ config, lib, pkgs, ... }:

{
  systemd = {
    # Set permissions in /persist for directories that are bind-mounted (also creates directories if they don't exist)
    tmpfiles.rules = [
      "d /persist/etc/NetworkManager/system-connections 0700 root root - -"   # NetworkManager connections
      "d /persist/etc/libvirt 0755 root root - -"                             # Libvirt network and config
      "d /persist/var/lib/tailscale 0700 root root - -"                       # Tailscale state
      "d /persist/var/lib/libvirt 0755 root root - -"                         # Libvirt state
      "d /persist/home/kevin/.ssh 0700 kevin users - -"                       # SSH keys
    ];
  };
}
