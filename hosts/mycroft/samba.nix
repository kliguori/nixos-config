{ config, lib, pkgs, ... }:

{
  users.groups.sambakevin = { };
  users.groups.sambajane = { };
  users.groups.sambajack = { };
  users.groups.sambashared = { };
  
  users.users.kevin = {
    isNormalUser = true;
    description = "Samba user Kevin";
    group = "sambakevin";                   # primary group
    extraGroups = [ "sambashared" ];        # can access shared directories
    createHome = false;                     # no home directory
    shell = "${pkgs.coreutils}/bin/false";  # prevent shell login
    hashedPassword = "!" ;                  # disable system login password
  };

  users.users.jane = {
    isNormalUser = true;
    description = "Samba user Jane";
    group = "sambajane";                    # primary group
    extraGroups = [ "sambashared" ];        # can access shared directories
    createHome = false;                     # no home directory
    shell = "${pkgs.coreutils}/bin/false";  # prevent shell login
    hashedPassword = "!" ;                  # disable system login password
  };

  users.users.jack = {
    isNormalUser = true;
    description = "Samba user Jack";
    group = "sambajack";                    # primary group
    extraGroups = [ ];                      # no extra groups
    createHome = false;                     # no home directory
    shell = "${pkgs.coreutils}/bin/false";  # prevent shell login
    hashedPassword = "!" ;                  # disable system login password
  };

  systemd.tmpfiles.rules = [
    "d /srv/users/kevin 0770 root sambakevin - -"
    "d /srv/users/jane  0770 root sambajane  - -"
    "d /srv/users/shared  0770 root sambashared  - -"
  ];

  services.samba = {
    enable = true;
    openFirewall = false;
    winbindd.enable = false;  # Disable winbindd
    settings = {
      global = {
        "security" = "user";
        "hosts allow" = "100.64.54. 10.54.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      
      "kevin" = {
        "path" = "/srv/users/kevin";
        "browseable" = "no";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0660";
        "directory mask" = "0770";
        "valid user" = "@sambakevin";
      };
      
      "jane" = {
        "path" = "/srv/users/jane";
        "browseable" = "no";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0660";
        "directory mask" = "0770";
        "valid user" = "@sambajane";
      };

      "shared" = {
        "path" = "/srv/users/shared";
        "browseable" = "no";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0660";
        "directory mask" = "0770";
        "valid user" = "@sambashared";
      };

      "media" = {
        "path" = "/srv/media";
        "browseable" = "no";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0660";
        "directory mask" = "0770";
        "valid user" = "@sambajack";
      };
    };
  };
}
