{ inputs, config, pkgs, ... }:

{
  home.username = "afonso";
  home.homeDirectory = "/home/afonso";

  home.packages = with pkgs; [
    # gtk theme
    dconf

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

    # TODO: sort
    alacritty
    bat
    brave
    discord
    docker
    dunst
    fastfetch
    # fd (better find)
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

    # scratchterm
    xdo
    xdotool

    # for copilot
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

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

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

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors; 
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "Joaquim Cunha";
    userEmail = "joaquimafonsocunha@gmail.com";
  };

  programs.zsh = {
    enable = true;
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -lah --color=always --group-directories-first";
      vim = "nvim";
      cat = "bat";
      repos = "cd $HOME/Documents/repos";
    };

    # for leave oh-my-zsh, later replace for custom config
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "zsh-sytax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }

      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];

    # TODO: check if there is a better way to do it
    initExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ] ; then
        eval `ssh-agent -s` > /dev/null 2>&1
        ssh-add ~/.ssh/github_ssh > /dev/null 2>&1
      fi
    '';
  };

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
