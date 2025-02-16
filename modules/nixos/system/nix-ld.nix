{ config, lib, ... }:

{
  config = lib.mkIf config.nix-ld.enable {
    programs.nix-ld.enable = true;
  };
}
