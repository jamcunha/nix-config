{ config, lib, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./user.nix
  ];

  config = lib.mkIf pkgs.stdenv.isLinux {
    console = {
      font = "Lat2-Terminus16";
      keyMap = lib.mkDefault "us";
      # useXkbConfig = true; # use xkb.options in tty.
    };

    system.stateVersion = config.home-manager.users.${config.user}.home.stateVersion;
  };
}
