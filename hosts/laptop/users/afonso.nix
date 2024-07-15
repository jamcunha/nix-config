{ config, pkgs, ... }: {
  users.users.${config.username} = {
    # Check this to add more groups later (https://github.com/Misterio77/nix-config/blob/main/hosts/common/users/gabriel/default.nix)

    isNormalUser = true;
    initialPassword = "123"; # Set this to something else.
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    packages = with pkgs; [ home-manager ];

    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ ];
  };
  programs.zsh.enable = true;
}
