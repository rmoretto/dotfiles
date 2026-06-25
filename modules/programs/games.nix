{self, ...}: {
  flake.modules.homeManager.games = {pkgs, ...}: {
    home.packages = [
      pkgs.steam-run
      pkgs.unstable.gamescope.override
      (_: {
        NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
      })
      pkgs.steam
    ];
  };

  flake.modules.nixos.games = {pkgs, ...}: {
    # Steam Usage: 
    #  env -u LD_PRELOAD gamescope -W 3440 -H 1440 -w 3440 -h 1440 -f -- env LD_PRELOAD="$LD_PRELOAD" %command%
    programs.gamescope = {
      enable = true;
      # https://github.com/ValveSoftware/gamescope/issues/1924#issuecomment-3725667842
      package = pkgs.gamescope.overrideAttrs (_: {
        NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
      });
    };

    programs.steam = {
      enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
