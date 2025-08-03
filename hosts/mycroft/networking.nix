{ config, lib, pkgs, ... }:

let
  # Configuration variables - easy to modify
  homeAssistant = {
    vmIP = "192.168.122.10";
    port = 8123;
    tailscaleInterface = "tailscale0";
    libvirtInterface = "virbr0";
  };

  # Helper function to generate iptables rules
  mkForwardRules = { vmIP, port, tailscaleInterface, libvirtInterface }: {
    # Rules to add when firewall starts
    add = ''
      # NAT: Forward incoming traffic on Tailscale interface to VM
      iptables -t nat -A PREROUTING -i ${tailscaleInterface} -p tcp --dport ${toString port} -j DNAT --to-destination ${vmIP}:${toString port}
      # FORWARD: Allow traffic from Tailscale to VM
      iptables -I FORWARD 1 -i ${tailscaleInterface} -o ${libvirtInterface} -p tcp --dport ${toString port} -j ACCEPT
      # FORWARD: Allow return traffic from VM to Tailscale
      iptables -I FORWARD 1 -i ${libvirtInterface} -o ${tailscaleInterface} -p tcp --sport ${toString port} -j ACCEPT
    '';
    # Rules to remove when firewall stops
    remove = ''
      # Clean up NAT rule (ignore errors if rule doesn't exist)
      iptables -t nat -D PREROUTING -i ${tailscaleInterface} -p tcp --dport ${toString port} -j DNAT --to-destination ${vmIP}:${toString port} 2>/dev/null || true
      # Clean up FORWARD rules (ignore errors if rules don't exist)
      iptables -D FORWARD -i ${tailscaleInterface} -o ${libvirtInterface} -p tcp --dport ${toString port} -j ACCEPT 2>/dev/null || true
      iptables -D FORWARD -i ${libvirtInterface} -o ${tailscaleInterface} -p tcp --sport ${toString port} -j ACCEPT 2>/dev/null || true
    '';
  };

  # Generate the rules for our Home Assistant setup
  forwardRules = mkForwardRules homeAssistant;
in {
  networking = {
    hostName = "mycroft";
    hostId = "ba087eb7";
    networkmanager.enable = true;
    
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 homeAssistant.port ];
      allowedUDPPorts = [  ];
      logRefusedConnections = true; # Log refused connections
      extraCommands = forwardRules.add; # Commands to run when firewall starts
      extraStopCommands = forwardRules.remove; # Commands to run when firewall stops (cleanup)
    };
  };
}