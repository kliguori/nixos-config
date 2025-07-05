{ config, lib, pkgs, ... }: {
  users.users.kevin = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$PtbhYydbhh.z0qInjgrQS1$0oLkk3FlJztVtmVJqpWQWCDs8kdX2zzMkJKQkkzAtu9";
    shell = pkgs.zsh;
    description = "Kevin Liguori";
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "libvirtd" 
      "kvm" 
    ];
  };
}