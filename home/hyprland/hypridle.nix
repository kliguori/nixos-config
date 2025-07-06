{ config, lib, pkgs, ... }: 

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 300;
          "on-timeout" = "brightnessctl set 10%";
          "on-resume"   = "brightnessctl set 100%";
        }
        {
          timeout = 600;
          "on-timeout" = "hyprlock";
        }
        {
          timeout = 900;
          "on-timeout" = "systemctl suspend";
        }
      ];
    };
  };
}
