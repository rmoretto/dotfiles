{
  programs.git = {
    enable = true;
    lfs.enable = true;
    aliases = {
      s = "status";
      a = "add";
      p = "push";
      c = "commit";
    };
  };
}
