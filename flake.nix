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
    globals = {
      user = "afonso";
      fullName = "Joaquim Cunha";
      gitName = "Joaquim Cunha";
      gitEmail = "joaquimafonsocunha@gmail.com";
    };

    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import nixpkgs { inherit system; };
    });
  in rec {
    nixosConfigurations = {
      laptop = import ./hosts/laptop { inherit inputs globals; };
    };

    homeConfigurations = {
      laptop = nixosConfigurations.laptop.config.home-manager.users.${globals.user}.home;
    };

    devShells = forEachSupportedSystem ({ pkgs }: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git

          lua-language-server
        ];
      };
    });
  };
}
