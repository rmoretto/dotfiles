{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      alias = {
        s = "status";
        a = "add";
        p = "push";
        c = "commit --verbose";
      };
      user.name = "rmoretto";
      user.email = "rodrigo.ce.moretto@gmail.com";

      init = {
        defaultBranch = "main";
      };
    };
    difftastic.enable = false;
  };
}
