{
  lib,
  config,
  ...
}: let
  cfg = config.services.mycosmic;
in {
  options.services.mycosmic = {
    enable = lib.mkEnableOption "mycosmic service";
    loginUser = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the COSMIC login manager
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.autoLogin = {
      enable = true;
      # Replace `yourUserName` with the actual username of user who should be automatically logged in
      user = cfg.loginUser;
    };

    # Enable the COSMIC desktop environment
    services.desktopManager.cosmic.enable = true;
  };
}
