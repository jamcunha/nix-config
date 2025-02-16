{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.virt-manager.enable && pkgs.stdenv.isLinux) {
    environment.systemPackages = with pkgs; [
      virtiofsd
    ];

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    home-manager.users.${config.user}.dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true; # For clipboard sharing
  };
}
