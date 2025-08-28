{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking = {
    hostName = "sherlock";
    hostId = "ba087eb7"; # head -c4 /dev/urandom | od -A none -t x4
    useDHCP = lib.mkDefault true; # Set IP statically in Unifi controller (IP: )
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
      ];
      allowedUDPPorts = [ ];
      logRefusedConnections = true;
    };
  };
}
