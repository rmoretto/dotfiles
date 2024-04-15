{ pkgs, ... }: {
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;

  home.file.".config/rofi" = {
    source = ../../configs/rofi;
    recursive = true;
  };
}
