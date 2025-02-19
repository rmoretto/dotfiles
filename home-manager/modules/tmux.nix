{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    historyLimit = 10000;
    escapeTime = 10;
    mouse = true;
    shell = "${pkgs.fish}/bin/fish";
    tmuxinator.enable = true;
    clock24 = true;
    keyMode = "vi";
    plugins = with pkgs; [
      tmuxPlugins.tilish
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-plugins "cpu-usage ram-usage git"
          set -g @dracula-show-left-icon session
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-fahrenheit false
          set -g @dracula-show-location false
        '';
      }
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",*256col*:Tc:RGB"

      # Remap copy mode
      bind-key -n 'C-M-\' copy-mode

      # Vi mappings for copy-mode: https://unix.stackexchange.com/a/585672/410321
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      # Also copy to system clipboard
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -sel clip -i'
    '';
  };

  # ---- tmuxinator Configuration ---- #
  home.file.".config/tmuxinator" = {
    source = ../../configs/tmuxinator;
    recursive = true;
  };
}
