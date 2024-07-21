{ config, lib, ... }:

{
  imports = [
    ./theme.nix
  ];

  options.gui = {
    enable = lib.mkEnableOption {
      description = "Enable GUI";
      default = false;
    };

    wm = {
      bspwm = lib.mkEnableOption {
        description = "Enable bspwm window manager";
        default = false;
      };

      # To add more window managers, add more options here
      # wm2 = lib.mkEnableOption {
      #   description = "Enable wm2 window manager";
      #   default = false;
      # };
    };

    launcherCmd = lib.mkOption {
      type = lib.types.str;
      description = "Command used to run the launcher";
    };

    powermenuCmd = lib.mkOption {
      type = lib.types.str;
      description = "Command used to run the powermenu";
    };

    barCmd = lib.mkOption {
      type = lib.types.str;
      description = "Command used to run the bar";
    };
  };

  # Enable Hardware Acceleration
  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
