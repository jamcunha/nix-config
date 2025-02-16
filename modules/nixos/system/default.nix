{
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./locale.nix
    ./nix-ld.nix
    ./user.nix
  ];

  options = {
    nix-ld.enable = lib.mkEnableOption {
      description = "Enable nix-ld";
      default = false;
    };
  };

  config = lib.mkIf pkgs.stdenv.isLinux {
    console = {
      font = "Lat2-Terminus16";
      keyMap = lib.mkDefault "us";
      # useXkbConfig = true; # use xkb.options in tty.
    };
  };
}
