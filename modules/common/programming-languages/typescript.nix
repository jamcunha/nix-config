{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.programming-languages.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        nodejs
        pnpm
        
        typescript-language-server
        prettierd
      ];
    };
  };
}
