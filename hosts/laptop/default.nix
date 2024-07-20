{ inputs, ... }: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };
in

inputs.nixpkgs.lib.nixosSystem {
  inherit pkgs;

  system = "x86_64-linux";
  specialArgs = { inherit inputs; };

  modules = [
    ./default-bak.nix

    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."afonso" = import ../../home/afonso;
    }
  ];
}
