{...}: {
  imports = [
    ./x11.nix
  ];

  services.xserver.windowManager.bspwm.enable = true;
  services.displayManager.defaultSession = "none+bspwm";
}
