{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./mouse.nix
    ./sound.nix
  ];

  options = {
    sound-cfg.enable = lib.mkEnableOption {
      description = "Enable sound support";
      default = false;
    };
  };

  # Maybe add some options to difference a server
}
