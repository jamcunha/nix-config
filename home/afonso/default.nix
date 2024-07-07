{ inputs, config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./themes.nix
    ./zsh.nix
    ./alacritty.nix
  ];

  home.username = "afonso";
  home.homeDirectory = "/home/afonso";

  home.packages = with pkgs; [
    # TODO: sort
    bat
    brave
    discord
    docker
    dunst
    fastfetch
    # fd (better find) (used in neovim)
    feh
    flameshot
    fzf
    gimp
    gnugrep
    htop
    jq
    killall
    lutris
    mpv
    neovim
    nitrogen
    onlyoffice-bin
    pavucontrol
    qbittorrent
    ripgrep
    rofi
    xfce.thunar
    tldr
    tmux
    tree
    unzip
    wget
    xorg.xkill
    zip

    # for neovim
    xclip

    # scratchterm (maybe add to bspwm nix config)
    xdo
    xdotool

    # for copilot (maybe add an overlay)
    nodejs_22
  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "alacritty";
    TERM = "xterm-256color";
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

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
