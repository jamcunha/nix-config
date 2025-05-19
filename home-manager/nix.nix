{pkgs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
  };

  programs.home-manager.enable = true;
}
