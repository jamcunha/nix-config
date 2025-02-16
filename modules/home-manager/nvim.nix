{ config, ... }:
{
  programs.neovim.enable = true;

  programs.git.extraConfig.core.editor = "nvim";
  home.sessionVariables.EDITOR = "nvim";

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nvim";
}
