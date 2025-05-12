{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  boot = {
    # Windows drive support
    # supportedFilesystems = [ "ntfs" ];

    kernelPackages = cfg.kernelPackages or pkgs.linuxPackages_latest;
  };
}
