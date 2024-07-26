{ config, lib, pkgs, ... }: let
  ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  options = {
    userGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of groups that users should be added to";
      default = [ ];
    };
  };

  config = {
    users.users.${config.user} = {
      isNormalUser = true;
      initialPassword = "123"; # Change after installation

      extraGroups = ifGroupExists config.userGroups ++ [ "wheel" ];

      packages = [ pkgs.home-manager ];
      openssh.authorizedKeys.keys = [ ];
    };

    home-manager.users.${config.user}.xdg = {
      mimeApps.enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        
        music = null;
        publicShare = null;
        templates = null;
      };
    };
  };
}
