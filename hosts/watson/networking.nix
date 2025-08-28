{
  lib,
  ...
}:

{
  networking = {
    hostName = "watson";
    hostId = "85b658cf"; # head -c4 /dev/urandom | od -A none -t x4
    useDHCP = lib.mkDefault true; 
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
      logRefusedConnections = true;
    };
  };
}
