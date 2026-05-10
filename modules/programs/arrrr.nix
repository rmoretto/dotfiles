{
  flake.modules.nixos.arrrr = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.services.mystream;
  in {
    options.services.mystream = {
      enable = lib.mkEnableOption "mystream service";
    };

    config = lib.mkIf cfg.enable {
      services.jellyfin = {
        enable = true;
        openFirewall = true;
      };

      services.sonarr = {
        enable = true;
        openFirewall = true;
      };

      services.jellyseerr = {
        enable = true;
        openFirewall = true;
      };

      services.qbittorrent = {
        enable = true;
      };

      services.jackett = {
        enable = true;
        openFirewall = true;
      };

      services.prowlarr = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
