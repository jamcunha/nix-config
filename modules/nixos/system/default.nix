{ config, lib, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./user.nix
  ];

  config = lib.mkIf pkgs.stdenv.isLinux {
    system.stateVersion = config.home-manager.users.${config.user}.home.stateVersion;
  };
}
