{
  flake.modules.homeManager.tmuxinator = { pkgs, ... }: {
    home.packaged = with pkgs; [ tmuxinator ];
    home.file.".config/tmuxinator" = {
      source = ./configs;
      recursive = true;
    };
  };
}
