{ config, lib, ... }:

{
  options.nix-ld.enable = lib.mkEnableOption {
    description = "Enable nix-ld";
    default = false;
  };

  config = lib.mkIf config.nix-ld.enable {
    programs.nix-ld.enable = true;
  };
}
