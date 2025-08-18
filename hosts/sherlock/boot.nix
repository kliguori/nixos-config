{ config, lib, pkgs, ... }: 

{
  boot = {

    kernelParams = [ 
      "zfs.zfs_arc_max=4294967296"   # Limit ZFS ARC size to 4GiB
    ];

    kernelModules = [ 
      "kvm-amd"   # Kernel module for AMD virtualization
      "sg"        # Kernel module for CD driver
    ];

    extraModulePackages = [ ];
    
    loader = { 
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ 
      "zfs"   # Support ZFS filesystems
    ];

    zfs.extraPools = [ 
      "rpool"      # Main ZFS root pool 
    ];

    initrd = {
      
      availableKernelModules = [ 
        "ahci" 
        "nvme" 
        "xhci_pci" 
        "usbhid" 
        "usb_storage" 
        "sd_mod" 
      ];
      
      kernelModules = [ ];
      
      # luks.devices."crypt-data".device = "/dev/disk/by-label/luks-storage-drive";
      
      # rollback to blank root
      postDeviceCommands = lib.mkAfter ''
        zpool import -N rpool
        zfs rollback -r rpool/root@blank
      '';
    
    };
  
  };
}