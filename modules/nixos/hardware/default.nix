{ lib, ... }:

{
  imports = [
    ./sound.nix
    ./boot.nix
  ];

  options = {
    soundCfg = {
      enable = lib.mkEnableOption {
        description = "Enable sound support";
        default = false;
      };

      # If more than one command is needed to control the volume use a package instead of a string
      volumeUp = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Command to increase the volume";
        default = null;
      };

      volumeDown = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Command to decrease the volume";
        default = null;
      };

      volumeToggle = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Command to toggle the volume";
        default = null;
      };
    };
  };

  # Maybe add some options to difference a server
}
