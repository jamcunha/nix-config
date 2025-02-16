{ lib, ... }:

{
  imports = [
    ./docker.nix
    ./virt-manager.nix
    ./zsh.nix # TODO: Add other shell options
    ./kanata.nix
  ];

  options = {
    docker.enable = lib.mkEnableOption {
      description = "Enable docker";
      default = false;
    };

    virt-manager.enable = lib.mkEnableOption {
      description = "Enable virt-manager";
      default = false;
    };

    kanata.enable = lib.mkEnableOption {
      description = "Enable kanata";
      default = false;
    };
  };
}
