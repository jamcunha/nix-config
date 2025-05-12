{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.docker.enable = lib.mkEnableOption {
    description = "Enable docker";
    default = false;
  };

  config = lib.mkIf (config.docker.enable && pkgs.stdenv.isLinux) {
    virtualisation.docker.enable = true;

    userGroups = [ "docker" ];
  };
}
