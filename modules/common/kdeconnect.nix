{ config, lib, ... }: {
  options.kdeconnect.enable = lib.mkEnableOption {
    description = "Enable KDE Connect";
    default = false;
  };

  config = lib.mkIf (config.gui.enable && config.kdeconnect.enable) {
    networking.firewall = {
      allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
      allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
    };

    home-manager.users.${config.user} = {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
  };
}
