{self, ...}: {
  flake.modules.homeManager.games = {pkgs, ...}: {
    home.packages = [
      pkgs.steam-run
      pkgs.unstable.gamescope
      pkgs.steam
    ];
  };

  flake.modules.nixos.games = {pkgs, ...}: {
    # home-manager.sharedModules = [
    #   self.modules.homeManager.games
    # ];

    # environment.systemPackages = [ pkgs.unstable.gamescope ];
    #
    programs.steam = {
      enable = true;
      # extraPackages = [ pkgs.unstable.gamescope ];
      gamescopeSession = {
        enable = true;
        env = {
          WLR_RENDERER = "vulkan";
          DXVK_HDR = "1";
          ENABLE_GAMESCOPE_WSI = "1";
          WINE_FULLSCREEN_FSR = "1";
          # Games allegedly prefer X11
          SDL_VIDEODRIVER = "x11";
        };
        args = [
          # "--xwayland-count 2"
          "--expose-wayland"

          "-e" # Enable steam integration
          "--steam"

          "--adaptive-sync"
          "--hdr-enabled"
          "--hdr-itm-enable"

          "--output-width 3440"
          "--output-height 1440"
          "-r 165"

          "--prefer-vk-device" # lspci -nn | grep VGA
          # "1002:73ef" # Dedicated
          # 1002:1681 # Integrated
        ];
      };
    };
  };
}
