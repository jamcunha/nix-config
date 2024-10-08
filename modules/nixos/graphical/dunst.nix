{
  config,
  lib,
  pkgs,
  ...
}:

{
  # TODO: change colors to system wide base16

  config = lib.mkIf config.gui.enable {
    home-manager.users.${config.user}.services.dunst = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
        size = "32x32";
      };

      settings = {
        global = {
          width = 300;
          height = 300;
          origin = "top-right";
          offset = "9x37";

          frame_width = 2;
          frame_color = "#6272a4";

          font = "FiraMono Nerd Font 10";
        };

        urgency_low = {
          background = "#1a1b26";
          foreground = "#acb0d0";
        };

        urgency_normal = {
          background = "#1a1b26";
          foreground = "#acb0d0";
        };

        urgency_critical = {
          background = "#1a1b26";
          foreground = "#acb0d0";
          frame_color = "#f7768e";
        };
      };
    };
  };
}
