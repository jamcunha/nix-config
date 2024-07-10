{ inputs, config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./themes.nix
    ./zsh.nix
    ./alacritty.nix
    ./bspwm.nix
    ./tmux.nix
  ];

  home.username = "afonso";
  home.homeDirectory = "/home/afonso";

  home.packages = with pkgs; [
    # TODO: sort
    bat
    discord
    docker
    feh
    flameshot
    fzf
    gimp
    gnugrep
    htop
    jq
    mpv
    nitrogen
    onlyoffice-bin
    pavucontrol
    qbittorrent
    ripgrep
    rofi
    xfce.thunar
    tldr
    tree

    unzip
    zip

    wget

    xorg.xkill
    killall

    dunst
    libnotify

    firefox

    neovim
    # for neovim
    xclip
    fd # (better find) (used in neovim)
    nodejs_22 # for copilot (maybe add an overlay)

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
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    TERM = "xterm-256color";

    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # home.sessionPath = [
  #   "$HOME/.local/bin"
  # ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
