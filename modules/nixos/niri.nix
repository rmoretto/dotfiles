{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.services.myniri;
in {
  options.services.myniri = {
    enable = lib.mkEnableOption "myniri service";
    loginUser = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = {};

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.niri}/bin/niri";
          user = cfg.loginUser;
        };

        default_session = initial_session;
      };
    };
  };
}
