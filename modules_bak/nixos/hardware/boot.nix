{
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      # Windows drive support
      # supportedFilesystems = [ "ntfs" ];

      # Use latest kernel
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    };
  };
}
