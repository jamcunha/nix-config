{ config, lib, ... }:

{
  config = lib.mkIf config.gui.enable {
    services.libinput = {
      enable = true;

      # Enable natural scrolling
      touchpad.naturalScrolling = true;

      # Disable mouse acceleration
      mouse = {
        accelProfile = "flat";
        accelSpeed = "1.15";
      };
    };
  };
}
