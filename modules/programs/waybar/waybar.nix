{
  flake.modules.homeManager.waybar = {pkgs, ...}: {
    home.packages = with pkgs; [ waybar ];

    home.file.".config/waybar" = {
      source = ./configs;
      recursive = true;
    };
  };
}
