{ config, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./git.nix
    ./mpv.nix
    ./nvim.nix
    ./spotify.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix # TODO: add other shell options

    ./bspwm
  ];

  # TODO: Find a way to select options

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];

      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  xdg = {
    mimeApps.enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      music = null;
      publicShare = null;
      templates = null;
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    font = {
      name = "FiraMono Nerd Font";
      package = pkgs.nerd-fonts.fira-mono;
    };

    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  home = {
    username = "afonso";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";

    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;

      gtk.enable = true;
      x11.enable = true;
    };

    # NOTE: Look into this for wayland based
    keyboard = {
      layout = "us";
      options = [
        "eurosign:e"
        "caps:escape"
      ];
    };

    packages = with pkgs; [
      # fonts
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
      nerd-fonts.jetbrains-mono

      fd
      jq

      feh
      nitrogen

      # TODO: (?) add a zsh function to extract any type of archive
      unzip
      zip

      fzf
      ripgrep
      tldr
      tree

      # TODO: check vencord
      discord

      qbittorrent

      calibre
      evince
      gimp
      onlyoffice-bin
      pavucontrol
      xfce.thunar

      xorg.xkill
      killall
      xclip

      binutils
      gnugrep
      htop

      # TODO: (?) add config
      firefox

      # TODO: check gaming specialization
      (lutris.override {
        extraPkgs = pkgs: [
          wineWowPackages.stable
          winetricks
        ];
      })

      (prismlauncher.override {
        jdks = [
          temurin-bin-8
          temurin-bin-17
          temurin-bin-21
        ];
      })

      protonup

      # "device agnostic airdrop"
      localsend
    ];

    # May be needed for future use
    # sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
