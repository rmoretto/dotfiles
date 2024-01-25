{
  programs.rofi.enable = true;
  home.file.".config/rofi" = {
    source = ../../configs/rofi;
    recursive = true;
  };
}
