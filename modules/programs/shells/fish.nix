{self, ...}: {
  flake.modules.homeManager.fish = {pkgs, ...}: {
    home.packages = with pkgs; [
      xcowsay
      nix-your-shell
      eza
    ];

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;
      shellAliases = {
        pong = "ping 8.8.8.8";
        txs = "tmuxinator";
        vim = "nvim";
        myip = "curl -fSsL 'https://api.ipify.org?format=json' | jq \".ip\"";
        cowalert = "xcowsay --monitor 1 comando: \" $(history | tail -n1 | grep -oP '\''(?<=  )[^;]++'\'' | head -n1) \" acabou ";
        toclip = "xclip -selection clipboard";
        dotfiles = "cd /home/rodrigo/programations/misc/dotfiles/ && nvim .";
        granter = "cd /home/rodrigo/programations/granter/";
        conecta = "txs inova-defesa";
        otter = "txs otter";
        flowtify = "cd /home/rodrigo/programations/granter/flowtify/";
        ls = "eza";
        ll = "eza -la";
        ip = "ip -c";
        ciasc-vpn = "sudo openfortivpn sslvpn01.ciasc.gov.br --username=granter_rmoretto@vpn.ciasc.gov.br";
      };
      functions = {
        ssh = {
          description = "SSH with xterm-256color";
          body = ''
            TERM=xterm-256color command ssh $argv
          '';
        };
      };
      interactiveShellInit = ''
        set fish_greeting
        set EDITOR "nvim"

        nix-your-shell fish | source
      '';
    };
  };

  flake.modules.nixos.fish = {pkgs, ...}: {
    home-manager.sharedModules = [
      self.modules.homeManager.fish
    ];

    programs.fish.enable = true;
    environment.variables = {
      SHELL = "fish";
    };
  };
}
