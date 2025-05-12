{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  services.printing = {
    enable = true;

    drivers = cfg.printing.drivers;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  environment.systemPackages = [pkgs.cups-filters];
}
