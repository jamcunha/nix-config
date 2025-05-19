{config, ...}: let
  cfg = config.mySettings;
in {
  programs.git = {
    enable = true;
    userName = cfg.name;
    userEmail = cfg.email;
  };

  # GitHub CLI
  programs.gh.enable = true;
}
