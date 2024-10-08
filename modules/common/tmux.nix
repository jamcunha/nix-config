{
  config,
  lib,
  pkgs,
  ...
}:
let
  tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/dev -mindepth 1 -maxdepth 1 -type d | ${pkgs.fzf}/bin/fzf)
    fi

    if [[ -z $selected ]]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)

    if ! ${pkgs.tmux}/bin/tmux list-sessions | ${pkgs.gnugrep}/bin/grep -q "^$selected_name:"; then
        ${pkgs.tmux}/bin/tmux new-session -s $selected_name -c $selected
    else
        ${pkgs.tmux}/bin/tmux attach-session -t $selected_name
    fi
  '';
in
{
  options.tmux.enable = lib.mkEnableOption {
    description = "Enable tmux";
    default = false;
  };

  config = lib.mkIf (config.gui.enable && config.tmux.enable) {
    home-manager.users.${config.user} = {
      home.packages = [
        tmux-sessionizer
      ];

      programs.tmux = {
        enable = true;

        mouse = true;
        newSession = true;
        disableConfirmationPrompt = true;
        keyMode = "vi";
        shortcut = "a";
        baseIndex = 1;
        escapeTime = 0;

        terminal = "tmux-256color";
        shell = "${pkgs.zsh}/bin/zsh";

        extraConfig = ''
          # Color fix
          set -ag terminal-overrides ",xterm-256color:RGB"

          # Navigate Panes
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # Resize Panes
          bind -r H resize-pane -L 5
          bind -r J resize-pane -D 5
          bind -r K resize-pane -U 5
          bind -r L resize-pane -R 5

          # Split Panes
          bind | split-window -h
          bind - split-window -v

          # Kill Pane
          bind \; kill-pane

          # Kill Window
          bind \: kill-window

          # Navigate Windows
          bind -n M-h previous-window
          bind -n M-l next-window

          # Run tmux-sessionizer
          bind-key -r f run-shell "${pkgs.tmux}/bin/tmux neww ${tmux-sessionizer}/bin/tmux-sessionizer"

          # Copy mode
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      };
    };
  };
}
