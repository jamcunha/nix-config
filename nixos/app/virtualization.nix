{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  environment.systemPackages = with pkgs; [
    virtiofsd

    distrobox
  ];

  users.users.${cfg.username}.extraGroups = ["libvirtd"];

  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    qemu.runAsRoot = false;
  };

  services.spice-vdagentd.enable = true; # For clipboard sharing

  # virtualisation.waydroid.enable = true;
}
