# Font and theme configuration

{ pkgs, ... }: {
  home.packages = with pkgs; [
    # fonts
    font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "Hack"
        "Iosevka"
        "IosevkaTerm"
        "IosevkaTermSlab"
        "JetBrainsMono"
      ];
    })
  ];

  # make sure to have package installed in `environment.systemPackages`
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    enable = true;

    theme = {
      name = "Tokyonight-Dark-BL-LB";
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  # if for some reason it doesn't work just `nix-shell -p lxappearance` and apply it
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;

    x11.enable = true;
    gtk.enable = true;
  };

  fonts.fontconfig.enable = true;
}
