{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.gui.enable {
    fonts = {
      fontconfig.enable = true;

      packages = with pkgs; [
        font-awesome
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        nerd-fonts.hack
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nerd-fonts.iosevka-term-slab
        nerd-fonts.jetbrains-mono
      ];
    };

    services.dbus.packages = [ pkgs.dconf ];
    programs.dconf.enable = true;

    # Qt Theme (if needed, I personally don't mind the default since I normally don't use Qt apps)
    # qt = {
    #   enable = true;
    #
    #   style = "gtk2";
    #   platformTheme = "gtk2";
    # };

    home-manager.users.${config.user} = {
      gtk =
        let
          gtkExtraConfig = {
            gtk-application-prefer-dark-theme = true;
          };
        in
        {
          enable = true;

          theme = {
            name = "Tokyonight-Dark";
            package = pkgs.tokyonight-gtk-theme;
          };

          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };

          gtk3.extraConfig = gtkExtraConfig;
          gtk4.extraConfig = gtkExtraConfig;
        };

      home.pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 20;
        gtk.enable = true;

        x11.enable = config.services.xserver.enable;
      };
    };
  };
}
