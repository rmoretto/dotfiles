{
  programs.git = {
    enable = true;
    lfs.enable = true;
    aliases = {
      s = "status";
      a = "add";
      p = "push";
      c = "commit --verbose";
    };
    userName = "rmoretto";
    userEmail = "rodrigo.ce.moretto@gmail.com";
    difftastic.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
