{
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";
      extraLocaleSettings.LC_TIME = lib.mkDefault "pt_PT.UTF-8";

      supportedLocales = lib.mkDefault [
        "en_US.UTF-8/UTF-8"
        "pt_PT.UTF-8/UTF-8"
      ];
    };

    time.timeZone = lib.mkDefault "Europe/Lisbon";
  };
}
