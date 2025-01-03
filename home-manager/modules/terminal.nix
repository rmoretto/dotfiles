{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "colored-man-pages"
        "mix"
        "tmuxinator"
        "docker-compose"
        "docker"
      ];
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      myip = "curl -fSsL 'https://api.ipify.org?format=json' | jq \".ip\"";
      ssh = "TERM=xterm-256color ssh";
      cowalert = "xcowsay --monitor 1 comando: \" $(history | tail -n1 | grep -oP '\''(?<=  )[^;]++'\'' | head -n1) \" acabou ";
      toclip = "xclip -selection clipboard";
      dotfiles = "cd /home/rodrigo/programations/misc/dotfiles/ && nvim .";
      granter = "cd /home/rodrigo/programations/granter/";
      conecta = "txs inova-defesa";
      flowtify = "cd /home/rodrigo/programations/granter/flowtify/";
      ls = "eza";
      ll = "eza -la";
      ip = "ip -c";
      ciasc-vpn = "sudo openfortivpn sslvpn01.ciasc.gov.br --username=granter_rmoretto@vpn.ciasc.gov.br";
    };
    initExtra = ''
      _ssh_configfile()
      {
          set -- "''${words[@]}"
          while [[ $# -gt 0 ]]; do
              if [[ $1 == -F* ]]; then
                  if [[ ''${#1} -gt 2 ]]; then
                      configfile="$(dequote "''${1:2}")"
                  else
                      shift
                      [[ $1 ]] && configfile="$(dequote "$1")"
                  fi
                  break
              fi
              shift
          done
      }
      complete -F _ssh_configfile get-ssh-hostname

      ### Fix slowness of pastes with zsh-syntax-highlighting.zsh
      pasteinit() {
        OLD_SELF_INSERT=''${''${(s.:.)widgets[self-insert]}[2,3]}
        zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
      }

      pastefinish() {
        zle -N self-insert $OLD_SELF_INSERT
      }
      zstyle :bracketed-paste-magic paste-init pasteinit
      zstyle :bracketed-paste-magic paste-finish pastefinis

      ### Add ssh key to ssh-agent
      eval $(ssh-agent) && ssh-add ~/.ssh/id_ed25519 > /dev/null
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 10.25;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "regular";
        };
      };
      colors = {
        primary = {
          background = "#1f1f28";
          foreground = "#dcd7ba";
        };
      };
      terminal.shell = "${pkgs.zsh}/bin/zsh";
      # window.opacity = 0.8;
      window.padding = {
        x = 5;
        y = 5;
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
