{self, ...}: {
  flake.modules.homeManager.i3 = {
    pkgs,
    config,
    ...
  }: {
    xsession.windowManager.i3.enable = true;

    home.file.".config/i3" = {
      source = ./configs/i3;
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
      script = builtins.readFile ./configs/polybar/launch.sh;
    };

    home.file.".config/polybar" = {
      source = ./configs/polybar;
      recursive = true;
    };

    home.packages = with pkgs; [
      unstable.picom
    ];

    xdg.configFile."picom/picom.conf".source = ./configs/picom/picom.conf;

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

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.posy-cursors;
      name = "Posy_Cursor_Black";
      size = 12;
    };
  };

  flake.modules.nixos.i3 = {pkgs, ...}: {
    home-manager.sharedModules = [
      self.modules.homeManager.i3
    ];
  };
}
