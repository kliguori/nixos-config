{ config, lib, pkgs, ... }:

{
  # Enable zrepl
  services.zrepl = {
    enable = true;
    
    settings = {
      # Global settings
      global = {
        logging = [
          {
            type = "stdout";
            level = "info";
            format = "human";
          }
          {
            type = "syslog";
            level = "warn";
            format = "human";
          }
        ];
      };
      
      # Jobs configuration
      jobs = [
        {
          name = "local_backup";
          type = "push";
          
          # What to replicate
          filesystems = {
            "data-pool/media<" = true;           # < means include children
            "data-pool/photos<" = true;
            "data-pool/users<" = true;
            "data-pool/virtual-machines<" = true;
          };
          
          # Where to replicate to
          connect = {
            type = "local";
          };
          
          # Target configuration
          root_fs = "backup-pool";
          
          # Snapshot settings
          snapshotting = {
            type = "periodic";
            prefix = "zrepl_";
            interval = "1h";    # Create snapshots every hour
            
            # Snapshot retention on source
            hooks = [
              {
                type = "command";
                path = "/bin/true";  # Placeholder - could add custom hooks
              }
            ];
          };
          
          # Replication schedule
          replication = {
            # Replication interval
            interval = "10m";   # Check for new snapshots every 10 minutes
            
            # Compression during replication
            protection = {
              initial = "guarantee_resumability";
              incremental = "guarantee_resumability";
            };
          };
          
          # Retention policy on target
          pruning = {
            keep_sender = [
              {
                type = "not_replicated";
              }
              {
                type = "last_n";
                count = 10;
              }
            ];
            keep_receiver = [
              {
                type = "grid";
                grid = "1x1h(keep=all) | 24x1h | 7x1d | 4x7d | 12x30d";
              }
            ];
          };
        }
        
        # Alternative: Manual snapshot job (if you prefer sanoid for snapshots)
        {
          name = "manual_backup";
          type = "push";
          
          filesystems = {
            "data-pool/media<" = true;
            "data-pool/users<" = true; 
            "data-pool/virtual-machines<" = true;
          };
          
          connect = {
            type = "local";
          };
          
          root_fs = "backup-pool";
          
          # Use existing snapshots (from sanoid)
          snapshotting = {
            type = "manual";
          };
          
          replication = {
            interval = "30m";   # Check every 30 minutes
          };
          
          pruning = {
            keep_sender = [
              {
                type = "not_replicated";
              }
            ];
            keep_receiver = [
              {
                type = "regex";
                regex = "^(autosnap_.*|zrepl_.*)";
              }
              {
                type = "last_n"; 
                count = 50;     # Keep last 50 snapshots
              }
            ];
          };
        }
      ];
    };
  };
  
  # Make sure ZFS is available
  boot.supportedFilesystems = [ "zfs" ];
  
  # Optional: Enable prometheus metrics for monitoring
  services.zrepl.settings.global.monitoring = [
    {
      type = "prometheus";
      listen = ":9811";
    }
  ];
}