{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    historyLimit = 10000;
    escapeTime = 10;
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    tmuxinator.enable = true;
    plugins = with pkgs; [
      tmuxPlugins.tilish
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",*256col*:Tc:RGB"
    '';
  };

  # ---- tmuxinator Configuration ---- #
  home.file.".config/tmuxinator" = {
    source = ../../configs/tmuxinator;
    recursive = true;
  };
}
