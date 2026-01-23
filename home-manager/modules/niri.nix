{pkgs, ...}: {
  home.packages = with pkgs; [
    alacritty 
    fuzzel 
    swaylock 
    mako 
    swayidle
    xwayland-satellite
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty -e";
        prompt = ">> ";
        layer = "overlay";
      };

      border = {
        radius = 10;
        width = 4;
      };
    };
  };
}
