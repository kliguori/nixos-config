{
  pkgs,
  ...
}:

{
  virtualisation = {
    docker.enable = true; # Enable docker
    libvirtd = {
      # Enable QEMU and KVM
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true; # Enable OVMF for UEFI support
        runAsRoot = true; # Allow running as root
      };
    };
  };
}
