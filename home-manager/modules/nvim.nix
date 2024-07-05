{pkgs, ...}: {
  programs.neovim.enable = true;
  programs.neovim.package = pkgs.unstable.neovim-unwrapped;

  home.file.".config/nvim" = {
    source = ../../configs/nvim;
    recursive = true;
  };

  home.file.".config/nvim/lua/lsp_location.lua" = with pkgs; {
    text = ''
      return {
        bashls = { "${unstable.nodePackages.bash-language-server}/bin/bash-language-server", "start" },
        dockerls = { "${unstable.dockerfile-language-server-nodejs}/bin/docker-langserver", "--stdio" },
        efm = { "${unstable.efm-langserver}/bin/efm-langserver" },
        elixirls = { "${unstable.elixir-ls}/bin/elixir-ls" },
        eslint = { "${unstable.vscode-langservers-extracted}/bin/vscode-eslint-language-server", "--stdio" },
        html = { "${unstable.vscode-langservers-extracted}/bin/vscode-html-language-server", "--stdio" },
        json = { "${unstable.vscode-langservers-extracted}/bin/vscode-json-language-server", "--stdio" },
        cssls = { "${unstable.vscode-langservers-extracted}/bin/vscode-css-language-server", "--stdio" },
        marksman = { "${unstable.marksman}/bin/marksman", "server" },
        tsserver = { "${unstable.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" },
        volar = { "${nodePackages.volar}/bin/vue-language-server", "--stdio" },
        nil_ls = { "${unstable.nil}/bin/nil" },
        lua_ls = { "${unstable.lua-language-server}/bin/lua-language-server" },
        tailwindcss = { "${unstable.tailwindcss-language-server}/bin/tailwindcss-language-server" }
      }
    '';
  };

  # nil = "${unstable.nil}/bin/nil"

  home.packages = with pkgs; [
    unstable.elixir-ls
    unstable.nodePackages.bash-language-server
    unstable.dockerfile-language-server-nodejs
    unstable.efm-langserver
    unstable.vscode-langservers-extracted
    unstable.marksman
    unstable.nodePackages.typescript-language-server
    nodePackages.volar
    unstable.nil
    unstable.lua-language-server
    unstable.tailwindcss-language-server
  ];
}
