{ lib, pkgs, config, ... }: let
  cfg = config.home.my-quickshell;
in {
  options.home.my-quickshell = {
    enable = lib.mkEnableOption "my-quickshell";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      quickshell
    ];
  };
}
