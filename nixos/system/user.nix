{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  users.users.${cfg.username} = {
    isNormalUser = true;
    initialPassword = "123"; # Change after installation

    # TODO: maybe add hashed password

    extraGroups = ["wheel" "networkmanager" "video"];

    packages = [pkgs.home-manager];

    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
