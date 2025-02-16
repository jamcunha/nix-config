{ inputs, pkgs, ... }:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      
      shuffle
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];

    theme = spicePkgs.themes.spotifyNoPremium;
  };
}
