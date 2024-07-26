{ config, lib, ... }:

{
  options.starship.enable = lib.mkEnableOption {
    description = "Enable starship prompt";
    default = false;
  };

  config = {
    home-manager.users.${config.user} = {
      programs.starship = let
        promptOrder = [
          "character"
          "directory"
          "git_branch"
          "git_status"
          "nix_shell"
        ];

        promptFormat = lib.concatStrings (map (s: "\$${s}") promptOrder);
      in
      {
        enable = true;

        settings = {
          add_newline = false;

          format = promptFormat;

          character = {
            success_symbol = "[➜](bold green) ";
            error_symbol = "[➜](bold red) ";
          };

          git_branch = {
            format = "[git:\\([$branch](bold red)\\)]($style) ";
            style = "bold blue";
          };
        };
      };
    };
  };
}
