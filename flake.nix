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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      hardware,
      disko,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );

      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in {
      inherit lib;

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        laptop = lib.nixosSystem {
          modules = [ ./hosts/laptop outputs.nixosModules ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "afonso@laptop" = lib.homeManagerConfiguration {
          # FIX: some problem with home-manager config
          inherit pkgs;
          modules = [ ./hosts/laptop/home.nix outputs.homeManagerModules ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };

      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
            buildInputs = with pkgs; [
              git

              lua
            ];
          };
        }
      );
    };
}
