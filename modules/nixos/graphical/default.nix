{ config, lib, ... }:

{
  options.gui = {
    enable = lib.mkEnableOption {
      description = "Enable GUI";
      default = false;
    };
  };

  # Enable Hardware Acceleration
  config = lib.mkIf config.gui.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # TODO: Options for more than one login manager
    services.xserver.displayManager.lightdm.enable = true;
  };
}
