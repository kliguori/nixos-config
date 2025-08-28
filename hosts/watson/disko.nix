{ ... }:

{
  disko.devices = {
    disk.main = {
      device = "/dev/disk/by-id/REPLACE_ME";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "ESP";
            size = "1GiB";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "fmask=0022"
                "dmask=0022"
              ];
              extraArgs = [
                "-n"
                "NIXBOOT"
              ];
            };
          };

          luks = {
            name = "cryptroot";
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot"; # /dev/mapper/cryptroot
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };

    zpool.rpool = {
      type = "zpool";

      options = {
        ashift = "12";
        autotrim = "on";
      };

      rootFsOptions = {
        mountpoint = "none";
        compression = "zstd";
        atime = "off";
        xattr = "sa";
        acltype = "posixacl";
      };

      datasets = {
        root = {
          type = "zfs_dataset";
          mountpoint = "/";
          options = {
            canmount = "noauto";
          };
        };

        nix = {
          type = "zfs_dataset";
          mountpoint = "/nix";
          options = {
            atime = "off";
          };
        };

        persist = {
          type = "zfs_dataset";
          mountpoint = "/persist";
        };

        kevin = {
          type = "zfs_dataset";
          mountpoint = "/home/kevin";
        };

        crypt = {
          type = "zfs_dataset";
          mountpoint = "/home/kevin/crypt";
          options = {
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
            keylocation = "prompt";
          };
        };
      };
    };
  };
}
