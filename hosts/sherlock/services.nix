{ config, lib, pkgs, ... }:

{
  services = {
    blueman.enable = false;      # Disable Blueman service
    pulseaudio.enable = false;   # Disable pulseaudio
    
    zfs.autoScrub.enable = true;   # Enable automatic scrubbing of ZFS pools
    tailscale.enable = true;   # Enable  tailscale

    # Enable xserver and budgie desktop environment
    xserver = {
      enable = true;                          # Enable xserver
      displayManager.gdm.enable = true;      # Enable gdm display manager
      desktopManager.gnome.enable = true;    # Enable gnome desktop environment
      displayManager.lightdm.enable = false;  # Enable lightdm display manager
      desktopManager.budgie.enable = false;   # Enable budgie desktop environment
      videoDrivers = [ "nvidia" ];            # Use nvidia video drivers
    };
    
    # Enable pipewire
    pipewire = {                   
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Enable ssh service
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };  
  };
}
