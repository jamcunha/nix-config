{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  users.users.${cfg.username}.extraGroups = ["docker"];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
