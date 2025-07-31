{ config, lib, pkgs, ... }:

{
  users.groups.sambakevin = { };
  users.users.kevin = {
    isNormalUser = true;
    description = "Samba user Kevin";
    group = "sambakevin";         # primary group
    extraGroups = [ ];            # no extra groups
    createHome = false;           # no home directory
    shell = pkgs.nologin;         # prevent shell login
    password = "!" ;              # disable system login password
  };

  users.groups.sambajane = { };
  users.users.jane = {
    isNormalUser = true;
    description = "Samba user Jane";
    group = "sambajane";          # primary group
    extraGroups = [ ];            # no extra groups
    createHome = false;           # no home directory
    shell = pkgs.nologin;         # prevent shell login
    password = "!" ;              # disable system login password
  };

  systemd.tmpfiles.rules = [
    "d /srv/users/kevin 0770 root sambakevin - -"
    "d /srv/users/jane  0770 root sambajane  - -"
  ];

  services.samba = {
    enable = true;
    openFirewall = false;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "hosts allow" = "100.64.54. 10.54.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      
      "kevin" = {
        "path" = "/srv/users/kevin";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "kevin";
        "force group" = "sambakevin";
      };
      
      "jane" = {
        "path" = "/srv/users/jane";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "jane";
        "force group" = "sambajane";
      };
    };
  };
}
