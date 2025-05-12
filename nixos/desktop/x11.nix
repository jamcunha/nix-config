{pkgs, ...}: {
  imports = [
    ./dbus.nix
    ./fonts.nix
    ./pipewire.nix
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };
      excludePackages = [pkgs.xterm];

      displayManager.lightdm.enable = true;
    };

    libinput = {
      enable = true;

      # Disable mouse acceleration
      mouse = {
        accelProfile = "flat";
        accelSpeed = "1.15";
      };

      touchpad = {
        naturalScrolling = true;

        # Testing this
        disableWhileTyping = true;
      };
    };

    tumbler.enable = true;
  };
}
