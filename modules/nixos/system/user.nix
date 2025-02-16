{ config, pkgs, ... }: let
  ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  config = {
    users = {
      users."afonso" = {
        isNormalUser = true;
        initialPassword = "123"; # Change after installation
        shell = pkgs.zsh;

        # TODO: maybe add hashed password

        extraGroups = ifGroupExists [
          "video"
          "docker"
          "libvirtd"
          "uinput"
          "input"
        ] ++ [ "wheel" ];

        packages = [ pkgs.home-manager ];
        openssh.authorizedKeys.keys = [ ];
      };
    };

    home-manager.users."afonso" = import ../../../hosts/${config.networking.hostName}/home.nix;
  };
}
