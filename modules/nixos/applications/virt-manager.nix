{ config, lib, pkgs, ... }:

{
  options.virt-manager.enable = lib.mkEnableOption {
    description = "Enable virt-manager";
    default = false;
  };

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


    userGroups = [ "libvirtd" ];

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true; # For clipboard sharing
  };
}
