{pkgs, ...}: {
  xsession.windowManager.i3.enable = true;
  home.file.".config/i3" = {
    source = ../../configs/i3;
    recursive = true;
  };

  services.polybar = {
    enable = true;
    package = pkgs.unstable.polybar.override {
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
      i3Support = true;
    };
    script = builtins.readFile ../../configs/polybar/launch.sh;
  };

  home.file.".config/polybar" = {
    source = ../../configs/polybar;
    recursive = true;
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;
        icon_corner_radius = 0;
        indicate_hidden = "yes";
        transparency = 0;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 0;
        frame_color = "#aaaaaa";
        gap_size = 6;
        separator_color = "frame";
        sort = "yes";
        font = "Monospace 8";
        line_height = 0;
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        enable_recursive_icon_lookup = true;
        icon_theme = "Adwaita";
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 64;
        icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
        sticky_history = "yes";
        history_length = 20;
        dmenu = "/usr/bin/dmenu -p dunst:";
        browser = "/usr/bin/xdg-open";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 0;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
      };
      urgency_low = {
        background = "#1f1f28";
        foreground = "#dcd7ba";
        timeout = 10;
      };
      urgency_normal = {
        background = "#1f1f28";
        foreground = "#dcd7ba";
        timeout = 10;
      };
      urgency_critical = {
        background = "#c34043";
        foreground = "#dcd7ba";
        frame_color = "#e82424";
        timeout = 0;
      };
    };
  };

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "rebelot";
      repo = "kanagawa.nvim";
      rev = "58cdce2cb666e6e946edec0145f177f89ca4a9ad";
      sha256 = "sha256-TmuwIhjptegMcdwYToCTS9dyyndKzp5fJoahXF3F1K0=";
    }
    + "/extras/.Xresources"
  );

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
