{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    home-manager.users.${config.user} = {
      nix.gc = {
        automatic = config.nix.gc.automatic;
        options = config.nix.gc.options;
      };
    };

    nix = {
      nixPath = [ "nixpkgs=${pkgs.path}" ];

      registry.nixpkgs.to = {
        type = "path";
        path = builtins.toString pkgs.path;
      };

      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "ca-derivations"
        ];

        allowed-users = [
          "@wheel"
          config.user
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 10d";
      };
    };
  };
}
