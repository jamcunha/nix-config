{ config, lib, pkgs, ... }:

# NOTE: This is completely shit code, pls refactor later (and find a way to get spicetify-nix to here)

{
  options.spotify = { enable = lib.mkEnableOption {
      description = "Enable Spotify";
      default = false;
    };

    spicetify = {
      enable = lib.mkEnableOption {
        description = "Enable Spicetify";
        default = false;
      };

      input = lib.mkOption {
        description = "Spicetify input";
        type = lib.types.anything; # TODO: find type
      };

      # TODO: add options for extensions, themes, etc
      # for now it will be hard coded here
    };
  };

  config = lib.mkIf config.spotify.enable {
    home-manager.users.${config.user} = {
      imports = [ config.spotify.spicetify.input.homeManagerModules.default ];

      # I think this is not needed
      # home.packages = with pkgs; [
      #   spotify
      # ];

      programs.spicetify = let
        spicePkgs = config.spotify.spicetify.input.legacyPackages.${pkgs.system};
      in {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock

          shuffle
          beautifulLyrics
        ];

        theme = spicePkgs.themes.spotifyNoPremium;
      };
    };
  };
}
