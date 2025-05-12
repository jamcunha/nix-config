{inputs, ...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    settings = {
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  programs.nix-ld.enable = true;
}
