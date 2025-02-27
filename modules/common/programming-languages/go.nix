{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.programming-languages.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        go
        gotools

        gopls
        gofumpt
        goimports-reviser
        golines
        gomodifytags

        # to work with sql
        sqlc
        # to handle db migrations
        goose
      ];
    };
  };
}
