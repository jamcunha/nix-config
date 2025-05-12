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
