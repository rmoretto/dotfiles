{
  pkgs,
  ...
}: {
  xsession.windowManager.i3.enable = true;
  home.file.".config/i3" = {
    source = ../../configs/i3;
    recursive = true;
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
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

  services.dunst.enable = true;
  home.file.".config/dunst" = {
    source = ../../configs/dunst;
    recursive = true;
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
