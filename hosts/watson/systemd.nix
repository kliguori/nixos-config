{
  ...
}:

{
  systemd = {
    # Set permissions in /persist for directories that are bind-mounted (also creates directories if they don't exist)
    tmpfiles.rules = [
      "d /persist/etc/NetworkManager/system-connections 0700 root root - -" # NetworkManager connections
      "d /persist/var/lib/tailscale 0700 root root - -" # Tailscale state
    ];

  };
}
