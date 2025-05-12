{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
# NOTE: This is completely shit code, pls refactor later (and find a way to get spicetify-nix to here)
{
  options.spotify = {
    enable = lib.mkEnableOption {
      description = "Enable Spotify";
      default = false;
    };

    # spicetify = {
    #   enable = lib.mkEnableOption {
    #     description = "Enable Spicetify";
    #     default = false;
    #   };
    #
    #   # TODO: add options for extensions, themes, etc
    #   # for now it will be hard coded here
    # };
  };

  config = lib.mkIf config.spotify.enable {
    home-manager.users.${config.user} = {
      # NOTE: For now spicetify is default for spotify

      imports = [inputs.spicetify-nix.homeManagerModules.default];

      programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock

          shuffle
        ];

        enabledCustomApps = with spicePkgs.apps; [
          lyricsPlus
        ];
      };
    };
  };
}
