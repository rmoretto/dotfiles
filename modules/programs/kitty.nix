{self, ...}: {
  flake.modules.homeManager.kitty = {pkgs, ...}: {
    home.packages = with pkgs; [
      jetbrains-mono
    ];

    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.jetbrains-mono;
        size = 10.25;
      };
      settings = {
        background = "#1f1f28";
        foreground = "#dcd7ba";
        cursorColor = "#dcd7ba";
        color0 = "#090618";
        color8 = "#727169";
        color1 = "#c34043";
        color9 = "#e82424";
        color2 = "#76946a";
        color10 = "#98bb6c";
        color3 = "#c0a36e";
        color11 = "#e6c384";
        color4 = "#7e9cd8";
        color12 = "#7fb4ca";
        color5 = "#957fb8";
        color13 = "#938aa9";
        color6 = "#6a9589";
        color14 = "#7aa89f";
        color7 = "#c8c093";
        color15 = "#dcd7ba";

        # background_opacity = "0.75";
        enable_audio_bell = false;
        update_check_interval = 0;
        confirm_os_window_close = 0;

        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
        cursor_trail_start_threshold = 1;
      };
    };
  };

  flake.modules.nixos.kitty = {
    home-manager.sharedModules = [
      self.modules.homeManager.kitty
    ];
  };
}
