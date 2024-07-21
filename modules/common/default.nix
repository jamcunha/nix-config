{ config, lib, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./zsh.nix
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Full name of the primary user";
    };

    unfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of unfree packages to allow";
      default = [ ];
    };
  };

  config = let
    stateVersion = "24.05";
  in {
    # Host independant packages
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Go towards the commented code, for now allow all
    # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfreePackages;
    nixpkgs.config.allowUnfree = true;

    home-manager.users.${config.user}.home.stateVersion = stateVersion;
    home-manager.users.root.home.stateVersion = stateVersion;
  };
}
