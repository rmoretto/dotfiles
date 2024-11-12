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
}


