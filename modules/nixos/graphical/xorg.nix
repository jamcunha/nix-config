{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./dunst.nix
    ./polybar.nix
    ./rofi.nix
  ];

  config = lib.mkIf config.gui.enable {
    # TEMP: change after testing rofi.nix
    # gui.launcherCmd = "${pkgs.rofi}/bin/rofi -show drun";
    # gui.powermenuCmd = "$HOME/.config/rofi/powermenu/powermenu.sh";

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };

      displayManager.lightdm.enable = true;
    };

    environment.systemPackages = [ pkgs.xclip ];
  };
}
