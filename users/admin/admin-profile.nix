{ config, lib, pkgs, ... }: 

{
  users.users.admin = {
    isNormalUser = true;
    description = "Administrator User";
    shell = pkgs.zsh;
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "libvirtd" 
      "kvm" 
    ];
    hashedPassword = "$y$j9T$PtbhYydbhh.z0qInjgrQS1$0oLkk3FlJztVtmVJqpWQWCDs8kdX2zzMkJKQkkzAtu9";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIChaNoQCf9XHNZ7DR4mLD4k48MXPH53D1yO0K2Hk3ts9"
    ];
  };
}