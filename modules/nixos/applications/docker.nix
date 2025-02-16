{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.docker.enable && pkgs.stdenv.isLinux) {
    virtualisation.docker.enable = true;
  };
}
