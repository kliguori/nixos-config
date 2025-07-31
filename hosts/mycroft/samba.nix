{ config, lib, pkgs, ... }:

{
  users.groups = {
    sambakevin = { };
    sambajane = { };
  };

  systemd.tmpfiles.rules = [
    "d /srv/users/kevin 0770 root sambakevin - -"
    "d /srv/users/jane  0770 root sambajane  - -"
  ];

  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = false;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
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
    #   "jane" = {
    #     "path" = "/srv/users/jane";
    #     "browseable" = "yes";
    #     "read only" = "no";
    #     "guest ok" = "no";
    #     "create mask" = "0644";
    #     "directory mask" = "0755";
    #     "force user" = "jane";
    #     "force group" = "sambajane";
    #   };
    };
  };
}
