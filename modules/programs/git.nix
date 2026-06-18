{self, ...}: {
  flake.modules.homeManager.git = {...}: {
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

      ignores = [
        "TODO.md"
        "NOTES.md"
        "HISTORY_NOTES.md"
        "test.txt"
        "test.csv"
        "test.sqlite"
      ];

      # difftastic.enable = false;
    };
  };

  flake.modules.nixos.git = {
    home-manager.sharedModules = [
      self.modules.homeManager.git
    ];
  };
}
