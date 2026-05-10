{self, ...}: {
  flake.modules.homeMamanager.alacritty = {pkgs, ...}: {
    home.programs = [
      pkgs.jetbrains-mono
    ];

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
  };

  flake.modules.nixos.alacritty = {
    home-manager.sharedModules = [
      self.modules.homeManager.alacritty
    ];
  };
}
