{config, ...}: let
  cfg = config.mySettings;
in {
  imports = [
    ./settings.nix

    ../../home-manager/nix.nix
    ../../home-manager/theme.nix
    ../../home-manager/sh.nix

    ../../home-manager/app/browser/firefox.nix
    ../../home-manager/app/nvim/default.nix
    ../../home-manager/app/terminal/alacritty.nix
    ../../home-manager/app/calibre.nix
    ../../home-manager/app/cli.nix
    ../../home-manager/app/direnv.nix
    ../../home-manager/app/discord.nix
    ../../home-manager/app/gimp.nix
    ../../home-manager/app/git.nix
    ../../home-manager/app/localsend.nix
    ../../home-manager/app/mpv.nix
    ../../home-manager/app/office.nix
    ../../home-manager/app/qbittorrent.nix
    ../../home-manager/app/spotify.nix
    ../../home-manager/app/virtualization.nix
    ../../home-manager/app/zathura.nix

    ../../home-manager/programming-languages

    ../../home-manager/wm/bspwm
  ];

  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";

  home.stateVersion = "24.05";
}
