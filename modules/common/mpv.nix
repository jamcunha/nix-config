{ config, lib, ... }:

{
  options.mpv.enable = lib.mkEnableOption {
    description = "Enable MPV";
    default = false;
  };

  config = lib.mkIf config.mpv.enable {
    home-manager.users.${config.user} = {
      programs.mpv = {
        enable = true;

        config = {
          hwdec = "auto-safe";
          # hr-seek = "yes";
        };

        bindings = {
          RIGHT = "no-osd seek 5 exact";
          LEFT = "no-osd seek -5 exact";
          UP = "add volume 5";
          DOWN = "add volume -5";

          # TODO: add frame step to shift + left/right
        };
      };
    };
  };
}
