{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.programming-languages.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        python3

        basedpyright
        black
        isort
      ];
    };
  };
}
