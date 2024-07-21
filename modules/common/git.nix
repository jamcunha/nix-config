{ config, lib, ... }:

{
  options = {
    gitName = lib.mkOption {
      type = lib.types.str;
      description = "Name for git commits";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      description = "Email for git commits";
    };
  };

  config = {
    home-manager.users."${config.user}" = {
      programs.git = {
        enable = true;
        userName = config.gitName;
        userEmail = config.gitEmail;
      };

      # Github CLI
      programs.gh.enable = true;
    };
  };
}
