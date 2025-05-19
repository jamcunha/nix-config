{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  environment.systemPackages = with pkgs; [
    lutris
    wineWowPackages.stable

    winetricks
    protontricks
  ];

  # Esync (https://wiki.nixos.org/wiki/Lutris#Using_Esync)
  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  security.pam.loginLimits = [
    {
      domain = cfg.username;
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];
}
