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
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = true; # secret service
    security.pam.services.swaylock = {};
  };
}
