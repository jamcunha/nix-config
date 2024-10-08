{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.gui.enable && config.soundCfg.enable && pkgs.stdenv.isLinux) {
    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      jack.enable = true;
    };

    soundCfg.volumeUp = "${pkgs.pamixer}/bin/pamixer -i 1";
    soundCfg.volumeDown = "${pkgs.pamixer}/bin/pamixer -d 1";
    soundCfg.volumeToggle = "${pkgs.pamixer}/bin/pamixer -t";
  };
}
