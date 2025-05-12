{config, ...}: let
  cfg = config.mySettings;
in {
  time.timeZone = cfg.timezone;
  i18n.defaultLocale = cfg.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = cfg.locale;
    LC_IDENTIFICATION = cfg.locale;
    LC_MEASUREMENT = cfg.locale;
    LC_MONETARY = cfg.locale;
    LC_NAME = cfg.locale;
    LC_NUMERIC = cfg.locale;
    LC_PAPER = cfg.locale;
    LC_TELEPHONE = cfg.locale;
    LC_TIME = cfg.locale;
  };
}
