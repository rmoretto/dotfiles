{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    unstable.picom
  ];

  xdg.configFile."picom/picom.conf".source = ../../configs/picom/picom.conf;

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom X11 Compositor";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.unstable.picom}/bin/picom --config ${config.xdg.configFile."picom/picom.conf".source}";
    };
  };

  # services.picom = {
  #   package = pkgs.unstable.picom;
  #   enable = true;
  #   fade = true;
  #   fadeSteps = [0.1 0.1];
  #   shadow = true;
  #   shadowOffsets = [(-7) (-7)];
  #   shadowExclude = [
  #     "name = 'Notification'"
  #     "class_g = 'Conky'"
  #     "class_g ?= 'Notify-osd'"
  #     "class_g = 'Cairo-clock'"
  #     "class_g = ''"
  #     "_GTK_FRAME_EXTENTS@:c"
  #   ];
  #   inactiveOpacity = 0.9;
  #   wintypes = {
  #     tooltip = {
  #       fade = true;
  #       shadow = true;
  #       opacity = 1;
  #       focus = true;
  #       full-shadow = false;
  #     };
  #     dock = {
  #       shadow = false;
  #       clip-shadow-above = true;
  #     };
  #     dnd = {shadow = false;};
  #     dropdown_menu = {opacity = 1;};
  #     popup_menu = {
  #       shadow = false;
  #       fade = false;
  #     };
  #   };
  #   backend = "glx";
  #   opacityRules = [
  #     "100:name = 'Picture-in-Picture'"
  #     "100:class_g = 'Rofi'"
  #     "100:class_g = 'discord'"
  #   ];
  #   settings = {
  #     inactive-opacity-override = false;
  #     corner-radius = 8;
  #     frame-opacity = 0.7;
  #     rounded-corners-exclude = [
  #       "window_type = 'dock'"
  #       "window_type = 'desktop'"
  #     ];
  #     blur-kern = "3x3box";
  #     blur-background-exclude = [
  #       "window_type = 'dock'"
  #       "window_type = 'desktop'"
  #       "_GTK_FRAME_EXTENTS@:c"
  #     ];
  #     glx-no-stencil = true;
  #     shadow-radius = 7;
  #   };
  # };
}
