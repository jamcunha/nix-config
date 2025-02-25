{ lib, ... }:
{
  options.programming-languages.enable = lib.mkEnableOption {
    default = false;
    description = "Installs programming languages and the respective tools";
  };

  imports = [
    ./go.nix
    ./python.nix
    ./c.nix
    ./lua.nix
    ./nix.nix
    ./typescript.nix
    ./tailwind.nix
  ];
}
