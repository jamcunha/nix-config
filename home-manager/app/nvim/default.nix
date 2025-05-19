{
  config,
  pkgs,
  ...
}: {
  programs.neovim.enable = true;

  programs.git.extraConfig.core.editor = "nvim";

  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [
    tree-sitter
    gcc
    ripgrep

    # C/C++
    clang-tools

    # Go
    gopls
    gofumpt
    goimports-reviser
    golines

    # Lua
    lua-language-server
    stylua

    # Markdown
    marksman

    # Nix
    nixd
    alejandra

    # Python
    basedpyright
    black
    isort

    # Tailwind
    tailwindcss-language-server

    # Typescript / Javascript
    vtsls
    prettierd
    eslint_d
  ];

  # Maybe remove the symlink and update with `home-manager switch`, needs to add xdg.configFile.nvim.recursive = true
  # NOTE: mkOutOfStoreSymlink may not be needed
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home-manager/app/nvim/nvim";
}
