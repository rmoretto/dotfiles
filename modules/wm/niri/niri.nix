{self, inputs, ...}: {
  flake.modules.homeManager.niri = {pkgs, ...}: {
    imports = [
      # self.modules.homeManager.rofi
      # self.modules.homeManager.waybar
      # self.modules.homeManager.dunst
    ];

    home.packages = with pkgs; [
      xwayland-satellite
      unstable.quickshell
    ];

    # services.wpaperd.enable = true;
    # services.wpaperd.settings = {
    #   DP-4 = {
    #     path = "~/Pictures/Wallpapers/center.jpg";
    #   };
    #   DP-3 = {
    #     path = "~/Pictures/Wallpapers/left.jpg";
    #   };
    # };

    xdg.configFile."niri/config.kdl".source = ./configs/config.kdl;
    # services.mako.enable = true;

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.posy-cursors;
      name = "Posy_Cursor_Black";
      size = 16;
    };
  };

  flake.modules.nixos.niri = {
    pkgs,
    config,
    ...
  }: {
    home-manager.sharedModules = [
      self.modules.homeManager.niri
    ];

    imports = [
      # Import the dms-shell only available in unstable right now
      "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/dms-shell.nix"
      "${inputs.nixpkgs-unstable}/nixos/modules/programs/dsearch.nix"
    ];

    programs.niri.enable = true;
    programs.niri.package = pkgs.unstable.niri;

    programs.dsearch = {
      enable = true;
      package = pkgs.unstable.dsearch;
    };

    programs.dms-shell ={
      enable = true;
      package = pkgs.unstable.dms-shell;

      enableSystemMonitoring = false;
    };

    environment.systemPackages = with pkgs; [ unstable.dgop ];

    systemd.user.services.niri.enableDefaultPath = false;

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "rmoretto";
        };

        default_session = initial_session;
      };
    };

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
