{config, ...}: let
  cfg = config.mySettings;
in {
  # Enable uinput module
  boot.kernelModules = ["uinput"];

  hardware.uinput.enable = true;

  # Set udev rules for uinput
  boot.initrd.services.udev.rules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONs+="static_node=uinput"
  '';

  # Ensure uinput group exists
  users.groups.uinput = {};

  # Add user to group
  users.users.${cfg.username}.extraGroups = ["uinput" "input"];

  services.kanata = {
    enable = true;
    keyboards = {
      internal = {
        devices = cfg.kanata.devices;
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            caps a s d f j k l ;
          )

          (defvar
            tap-time 150
            hold-time 175
          )

          (defalias
            caps (tap-hold $tap-time $hold-time esc lctl)
            a (tap-hold $tap-time $hold-time a lmet)
            s (tap-hold $tap-time $hold-time s lalt)
            d (tap-hold $tap-time $hold-time d lsft)
            f (tap-hold $tap-time $hold-time f lctl)
            j (tap-hold $tap-time $hold-time j rctl)
            k (tap-hold $tap-time $hold-time k rsft)
            l (tap-hold $tap-time $hold-time l ralt)
            ; (tap-hold $tap-time $hold-time ; rmet)
          )

          (deflayer base
            @caps @a @s @d @f @j @k @l @;
          )
        '';
      };
    };
  };
}
