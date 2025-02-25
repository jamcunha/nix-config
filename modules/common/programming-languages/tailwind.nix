{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.programming-languages.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        tailwindcss
        tailwindcss-language-server
      ];
    };
  };
}
