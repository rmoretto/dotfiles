{pkgs, ...}: {
  home.packages = with pkgs; [eww];
  # programs.eww.enable = true;
  home.file.".config/eww" = {
    source = ../../configs/eww;
    recursive = true;
  };
}
