{config, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "eza -lah --color=always --group-directories-first";
      vim = "nvim";
      cat = "bat";
    };

    # for now leave oh-my-zsh, later replace for custom config
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git"];
    };

    initContent = ''
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward

      # Start ssh-agent and add needed ssh keys (TODO: Try doing this better)
      if ! pgrep -u $USER ssh-agent > /dev/null 2>&1; then
        eval $(ssh-agent -s) > /dev/null 2>&1

        echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK" > $HOME/.ssh/.ssh-agent-vars
        echo "SSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID" >> $HOME/.ssh/.ssh-agent-vars

        ssh-add $HOME/.ssh/github_ssh > /dev/null 2>&1
      fi

      if [ -f "$HOME/.ssh/.ssh-agent-vars" ]; then
        source "$HOME/.ssh/.ssh-agent-vars"
      fi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza -lah --color=always --group-directories-first";
      vim = "nvim";
      cat = "bat";
    };
  };

  programs.direnv.enableZshIntegration = config.programs.direnv.enable;
}
