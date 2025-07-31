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
    openFirewall = false;  
    
    settings = {
      "workgroup" = "WORKGROUP";
      "server string" = "NixOS NAS";
      "netbios name" = "nixnas";
      "security" = "user";
      "map to guest" = "never";
      "vfs objects" = "acl_xattr";
      "smb encrypt" = "required";
      "interfaces" = "tailscale0";
      "bind interfaces only" = "yes";
    };

    shares = {
      kevin = {
        path = "/srv/users/kevin";
        browseable = true;
        writable = true;
        "read only" = false;
        "valid users" = [ "kevin" ];
        "force group" = "sambakevin";
        "create mask" = "0660";
        "directory mask" = "0770";
      };  
    
      #jane = {
      #  path = "/srv/users/jane";
      #  browseable = true;
      #  writable = true;
      #  "read only" = false;
      #  "valid users" = [ "jane" ];
      #  "force group" = "sambajane";
      #  "create mask" = "0660";
      #  "directory mask" = "0770";
      #};
    };
  };
}
