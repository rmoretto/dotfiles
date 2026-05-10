{
  flake.modules.homeManager.tmuxinator = { pkgs, ... }: {
    home.packages = with pkgs; [ tmuxinator ];
    home.file.".config/tmuxinator" = {
      source = ./configs;
      recursive = true;
    };
  };
}
