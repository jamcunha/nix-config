{
  config,
  lib,
  ...
}:

{
  options.neovim.enable = lib.mkEnableOption {
    description = "Enable Neovim";
    default = false;
  };

  config = lib.mkIf config.neovim.enable {
    home-manager.users.${config.user} =
      { config, ... }: let
        inherit (config.lib.file) mkOutOfStoreSymlink;
      in {
        programs.neovim.enable = true;

        programs.git.extraConfig.core.editor = "nvim";

        home.sessionVariables.EDITOR = "nvim";

        xdg.configFile.nvim.source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nvim";
      };
  };
}
