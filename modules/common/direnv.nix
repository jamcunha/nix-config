{ config, lib, ... }:

{
  options.direnv.enable = lib.mkEnableOption {
    description = "Enable Direnv";
    default = false;
  };

  config = lib.mkIf config.direnv.enable {
    home-manager.users.${config.user} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.git.ignores = [
        ".direnv/**"
      ];
    };
  };
}
