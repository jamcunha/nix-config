{
  config,
  lib,
  ...
}:
{
  # TODO: add an option to add devices
  options.kanata.enable = lib.mkEnableOption {
    description = "Enable Kanata";
    default = false;
  };

  config = lib.mkIf (config.gui.enable && config.kanata.enable) {
    users.groups.uinput = {
      members = [ "${config.user}" ];
    };

    userGroups = [
      "uinput"
      "input"
    ];

    boot.initrd.services.udev.rules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONs+="static_node=uinput"
    '';

    services.kanata = {
      enable = true;
      keyboards = {
        internal = {
          devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
              caps a s d f j k l ;
            )

            (defvar
              tap-time 150
              hold-time 150
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
  };
}
