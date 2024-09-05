{ config, lib, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./git.nix
    ./mpv.nix
    ./nixpkgs.nix
    ./nvim.nix
    ./spotify.nix
    ./tmux.nix
    ./zsh.nix

    # temporary
    ./starship.nix
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Full name of the primary user";
    };

    # maybe add a option for the shell

    unfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of unfree packages to allow";
      default = [ ];
    };
  };

  config = let
    stateVersion = "24.05";
  in {
    # Host independant packages
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Go towards the commented code, for now allow all
    # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfreePackages;
    nixpkgs.config.allowUnfree = true;

    home-manager.users.${config.user} = {
      home.username = config.user;
      home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${config.user}" else "/home/${config.user}";

      # TODO: Check for better way to handle the configuration below ----------------------------------

      home.packages = with pkgs; [
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

        evince
        gimp
        onlyoffice-bin
        pavucontrol
        xfce.thunar

        xorg.xkill
        killall

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
      ];

      home.file = {

      };

      home.sessionVariables = {
        BROWSER = "firefox";
        TERM = "xterm-256color";

        # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };

      xdg.mimeApps = {
        enable = true;

        associations.added = {
          "application/pdf" = "evince.desktop";
          "text/html" = "firefox.desktop";
        };

        defaultApplications = {
          "application/pdf" = "org.gnome.Evince.desktop";
          "text/html" = "firefox.desktop";
        };
      };

      # -------------------------------------------------------

      home.stateVersion = stateVersion;
      programs.home-manager.enable = true;
    };

    home-manager.users.root.home.stateVersion = stateVersion;
  };
}
