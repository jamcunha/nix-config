{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.gui.enable && config.sound.enable && pkgs.stdenv.isLinux) {
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

    environment.systemPackages = with pkgs; [ pamixer playerctl ];
  };
}
