{ config, lib, pkgs, ... }:

{
  systemd = {
    # Set permissions in /persist for directories that are bind-mounted (also creates directories if they don't exist)
    tmpfiles.rules = [
      "d /persist/etc/NetworkManager/system-connections 0700 root root - -"   # NetworkManager connections
      "d /vmachines/ubuntu-dev 0775 root kvm - -"                             # ubuntu-dev virtual machine image
      "d /vmachines/the-ripper 0775 root kvm - -"                             # the-ripper virtual machine image
      "d /persist/var/lib/tailscale 0700 root root - -"                       # Tailscale state
      "d /persist/var/lib/libvirt 0755 root root - -"                         # Libvirt state
      "d /persist/home/kevin/.ssh 0700 kevin users - -"                       # SSH keys
      "d /persist/home/kevin/wallpapers 0755 kevin users - -"                 # Wallpapers
    ];

    # Note, this only writes the default.xml file to /etc/libvirt/qemu/networks/default.xml
    # All the libvirt network management must be done imperatively using virsh commands
    # First, take down any virtual machines that might be using the network
    # To check the status of the network, use:
    #   virsh net-list --all
    # Then take down the machines using the network:
    #   virsh shutdown <vm-name> (preferred)
    #   virsh destroy <vm-name>  (forceful)
    # To remove an old network, use:
    #   virsh net-destroy default
    #   virsh net-undefine default
    # To define the network, use:
    #   virsh net-define /etc/libvirt/qemu/networks/default.xml
    # To start the network, use:
    #   virsh net-start default
    # To autostart the network, use:
    #   virsh net-autostart default
    # Bring the virtual machines back up:
    #   virsh start <vm-name>
    # To check the status of the network, use:
    #   virsh net-info default
    # To check the status of the libvirt service, use:
    #   systemctl status libvirtd.service
    services.libvirt-define-default-net = 
    let
      defaultNetXml = builtins.readFile ./default.xml;
    in {
      description = "Define default libvirt NAT network when libvirtd starts";
      wantedBy = [ "multi-user.target" ];
      after = [ "libvirtd.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "libvirt-define-network" ''
          mkdir -p /etc/libvirt/qemu/networks
          echo '${defaultNetXml}' > /etc/libvirt/qemu/networks/default.xml
        '';
      };
    };
  };
}
