{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -lah --color=always --group-directories-first";
      vim = "nvim";
      cat = "${pkgs.bat}/bin/bat";
    };

    # for leave oh-my-zsh, later replace for custom config
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
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

    # TODO: check if there is a better way to do it
    initExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ] ; then
        eval `ssh-agent -s` > /dev/null 2>&1
        ssh-add ~/.ssh/github_ssh > /dev/null 2>&1
      fi
    '';
  };
}
