{
  config,
  pkgs,
  ...
}: {
  config = {
    users.users.${config.user}.shell = pkgs.zsh;
    programs.zsh.enable = true;

    home-manager.users.${config.user} = {
      programs.zsh = {
        enable = true;
        history.size = 10000;
        history.path = "${config.home-manager.users.${config.user}.xdg.dataHome}/zsh/history";

        shellAliases = {
          ls = "${pkgs.eza}/bin/eza -lah --color=always --group-directories-first";
          vim = "nvim"; # assumes nvim is installed
          cat = "${pkgs.bat}/bin/bat";
        };

        # for now leave oh-my-zsh, later replace for custom config
        oh-my-zsh = {
          enable = true;
          theme = "robbyrussell";
          plugins = ["git"];
        };

        plugins = [
          {
            name = "zsh-sytax-highlighting";
            src = pkgs.zsh-syntax-highlighting;
            file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
          }

          {
            name = "zsh-autosuggestions";
            src = pkgs.zsh-autosuggestions;
            file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
          }
        ];

        # Start ssh-agent and add needed ssh keys
        initContent = ''
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
    };
  };
}
