{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.neovim.enable = lib.mkEnableOption {
    description = "Enable Neovim";
    default = false;
  };

  config = lib.mkIf config.neovim.enable {
    home-manager.users.${config.user} =
      { config, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;
      in
      {
        home.packages = with pkgs; [
          neovim

          fd # (better find) (used in neovim?)
          nodejs_22 # for copilot (maybe add an overlay)
          jq # Think lsp's use it (test later)
          tree-sitter # executable for nvim-treesitter
        ];

        programs.git.extraConfig.core.editor = "nvim";

        home.sessionVariables.EDITOR = "nvim";

        xdg.configFile.nvim.source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nvim";
      };
  };
}
