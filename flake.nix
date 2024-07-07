{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hardware, disko, home-manager, ... }@inputs : let
    inherit (self) outputs;

    systems = [
      "x86_64-linux"
    ];

    lib = nixpkgs.lib // home-manager.lib;

    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
    };
  in {
    inherit lib;

    nixosConfigurations = {
      laptop = lib.nixosSystem {
        inherit pkgs;
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };

        modules = [
          ./hosts/laptop

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."afonso" = import ./home/afonso;
          }
        ];
      };
    };

    homeConfigurations."afonso" = lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs outputs; };

      modules = [
        ./home/afonso
      ];
    };
  };
}
