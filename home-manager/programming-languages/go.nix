{pkgs, ...}: {
  home.packages = with pkgs; [
    go
    gotools

    # to work with sql
    sqlc
    # to handle db migrations
    goose
  ];
}
