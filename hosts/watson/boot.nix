{
  lib,
  ...
}:

{
  boot = {

    kernelParams = [
      "zfs.zfs_arc_max=4294967296" # Limit ZFS ARC size to 4GiB
    ];

    kernelModules = [
      "kvm-amd" # Kernel module for AMD virtualization
    ];

    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "zfs" # Support ZFS filesystems
    ];

    zfs = {
      requestEncryptionCredentials = true;
      extraPools = [
        "rpool" # root pool
      ];
    };

    initrd = {

      supportedFilesystems = [
        "zfs"
      ];

      luks.devices.cryptroot.device = "/dev/disk/by-partlabel/disk-main-cryptroot";

      kernelModules = [ ];
      availableKernelModules = [
        "nvme"
        "ehci_pci"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      # rollback to blank root
      postDeviceCommands = lib.mkAfter ''
        zpool import -N rpool
        zfs rollback -r rpool/root@blank
      '';

    };

  };
}
