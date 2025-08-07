{ config, lib, pkgs, ... }:

{
  services.sanoid = {
    enable = true;
    datasets = {
      # Base policy for the entire pool
      "data-pool" = {
        useTemplate = [ "base" ];
        recursive = true;  # This applies base policy to all datasets
      };
      
      # Override for virtual-machines (adds hourly)
      "data-pool/virtual-machines" = {
        useTemplate = [ "withHourly" ];
        recursive = true;  # Applies to all VMs under this
      };
      
      # Override for all user datasets (adds hourly)
      "data-pool/users" = {
        useTemplate = [ "withHourly" ];
        recursive = true;  # Applies to kevin, jane, shared, etc.
      };
    };
    
    templates = {
      # Base template: daily, weekly, monthly only
      base = {
        frequently = 0;
        hourly = 0;         # No hourly snapshots
        daily = 7;          # 7 days
        weekly = 4;         # 4 weeks  
        monthly = 12;       # 12 months
        yearly = 0;
        autosnap = true;
        autoprune = true;
      };
      
      # Extended template: adds hourly snapshots
      withHourly = {
        frequently = 0;
        hourly = 24;        # 24 hours (1 day)
        daily = 7;          # 7 days
        weekly = 4;         # 4 weeks
        monthly = 12;       # 12 months  
        yearly = 0;
        autosnap = true;
        autoprune = true;
      };
    };
  };

  services.syncoid = {
    enable = true;
  
    commands = {
      "data-pool-backup" = {
        source = "data-pool";
        target = "backup-pool";

        recursive = true;

        extraArgs = [ 
          "--compress=zstd"           # Compress replication stream
          "--no-privilege-elevation"  # Don't use sudo (already root)
          "--no-sync-snap"            # Don't create sync snapshots (sanoid handles this)
        ];
      };
    };
    
    # Run twice daily: 12:30 AM and 12:30 PM
    interval = "*-*-* 13:00:00";
  };
}