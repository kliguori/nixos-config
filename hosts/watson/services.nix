{
  ...
}:

{
  services = {
    blueman.enable = true; # Disable Blueman service
    pulseaudio.enable = false; # Disable pulseaudio

    zfs.autoScrub.enable = true; # Enable automatic scrubbing of ZFS pools
    tailscale.enable = true; # Enable  tailscale

    # Disable xserver  
    xserver.enable = false; 

    # Enable pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

  };
}
