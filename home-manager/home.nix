# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.sops-nix.homeManagerModule
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "rmoretto";
    homeDirectory = "/home/rmoretto";
  };

  home.packages = with pkgs; [
    # Very Fun and games
    spotify
    discord
    
    # System utilities
    htop
    ncdu
    unzip
    jq
    ranger
    ripgrep
    fd
    killall
    pulseaudio
    fzf
    exa
    xcowsay
    xclip

    # networking
    openfortivpn

    # very cool code kid0
    vim
    nano
    vscode
    cargo
    rustc
    go
    gcc
    lua
    nodejs
    (let
      python3-with-packages = pkgs.python3.withPackages(p: with p; [
        pynvim
        setuptools
      ]);
    in
    python3-with-packages)
    jetbrains.pycharm-professional

    # Fonts
    nerdfonts
    jetbrains-mono
    iosevka
    iosevka-bin
    siji
    termsyn
    material-icons
    material-design-icons
    material-symbols
    terminus_font
    terminus-nerdfont
    fantasque-sans-mono
    noto-fonts
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # ---- Git Configuration ---- #
  programs.git = {
    enable = true;
    aliases = {
      s = "status";
      a = "add";
      p = "push";
    };
  };

  # ---- zsh Configuration ---- #
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "colored-man-pages"
        "mix"
        "tmuxinator"
        "docker-compose"
      ];
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      myip = "curl -fSsL 'https://api.ipify.org?format=json' | jq \".ip\"";
      ssh = "TERM=xterm-256color ssh";
      cowalert = "xcowsay --monitor 1 comando: \" $(history | tail -n1 | grep -oP '\''(?<=  )[^;]++'\'' | head -n1) \" acabou ";
      toclip = "xclip -selection clipboard";
      dotfiles = "cd /home/rodrigo/programations/misc/dotfiles/ && nvim .";
      granter = "cd /home/rodrigo/programations/granter/";
      conecta = "txs inova-defesa";
      flowtify = "cd /home/rodrigo/programations/granter/flowtify/";
      ls = "exa";
      ll = "exa -la";
      ip = "ip -c";
      ciasc-vpn = "sudo openfortivpn sslvpn01.ciasc.gov.br --username=granter_rmoretto@vpn.ciasc.gov.br";
    };
    initExtra = ''
    _ssh_configfile()
    {
        set -- "''${words[@]}"
        while [[ $# -gt 0 ]]; do
            if [[ $1 == -F* ]]; then
                if [[ ''${#1} -gt 2 ]]; then
                    configfile="$(dequote "''${1:2}")"
                else
                    shift
                    [[ $1 ]] && configfile="$(dequote "$1")"
                fi
                break
            fi
            shift
        done
    }
    complete -F _ssh_configfile get-ssh-hostname
    '';
  };

  # ---- Alacritty Configuration ---- #
  programs.alacritty = {
    enable = true;
    settings = {
      shell.program = (builtins.trace "${pkgs.zsh}/bin/zsh" "${pkgs.zsh}/bin/zsh");
      window.padding = {
        x = 5;
        y = 5;
      };
      font = {
        size = 10;
        normal = {
          font = "JetBrainsMono Nerd Font";
          style = "regular";
        };
      };
    };
  };

  # ---- Starship Configuration ---- #
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # ---- tmux Configuration ---- #
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    historyLimit = 10000;
    escapeTime = 10;
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.tilish
    ];
  };

  # ---- rofi Configuration ---- #
  programs.rofi = {
    enable = true;
  };

  # ---- nvim Configuration ---- #
  programs.neovim.enable = true;
  home.file.".config/nvim" = {
    source = ../configs/nvim;
    recursive = true;
  };

  # ---- i3 Configuration ---- #
  # xsession.scriptPath = ".hm-xsession";
  xsession.windowManager.i3.enable = true;
  home.file.".config/i3" = {
    source = ../configs/i3;
    recursive = true;
  };

  # ---- Polybar Configuration ---- #
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
      i3Support = true;
    };
    script = builtins.readFile ../configs/polybar/launch.sh;
  };

  home.file.".config/polybar" = {
    source = ../configs/polybar;
    recursive = true;
  };

  # ---- Dunst Configuration ---- #
  services.dunst.enable = true;
  home.file.".config/dunst" = {
    source = ../configs/dunst;
    recursive = true;
  };

  # ---- Xresources colors :) ---- #
  xresources.extraConfig = 
    builtins.readFile (
      pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "58cdce2cb666e6e946edec0145f177f89ca4a9ad";
          sha256 = "sha256-TmuwIhjptegMcdwYToCTS9dyyndKzp5fJoahXF3F1K0=";
      } + "/extras/.Xresources"
    );

  # ---- SSH Configs ---- #
  home.file.".ssh/config" = {
    source = ../configs/ssh/config;
  };

  # ---- Secrets Management with SOPS ---- #
  sops = {
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
    defaultSopsFile = ../secrets/common/secrets.yaml;

    secrets."ssh_keys/cbti/priv" = {
      path = "${config.home.homeDirectory}/.ssh/cbti";
      mode = "0600";
    };
    secrets."ssh_keys/cbti/pub" = {
      path = "${config.home.homeDirectory}/.ssh/cbti.pub";
      mode = "0644";
    };

    secrets."ssh_keys/ciasc_root/priv" = {
      path = "${config.home.homeDirectory}/.ssh/ciasc_root";
      mode = "0600";
    };
    secrets."ssh_keys/ciasc_root/pub" = {
      path = "${config.home.homeDirectory}/.ssh/ciasc_root.pub";
      mode = "0644";
    };

    secrets."ssh_keys/flowtify_pem/priv" = {
      path = "${config.home.homeDirectory}/.ssh/flowtify.pem";
      mode = "0600";
    };

    secrets."ssh_keys/google_compute_engine/priv" = {
      path = "${config.home.homeDirectory}/.ssh/google_compute_engine";
      mode = "0600";
    };
    secrets."ssh_keys/google_compute_engine/pub" = {
      path = "${config.home.homeDirectory}/.ssh/google_compute_engine.pub";
      mode = "0644";
    };

    secrets."ssh_keys/id_rsa/priv" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa";
      mode = "0600";
    };
    secrets."ssh_keys/id_rsa/pub" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
      mode = "0644";
    };

    secrets."ssh_keys/id_rsa_casa/priv" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa_casa";
      mode = "0600";
    };
    secrets."ssh_keys/id_rsa_casa/pub" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa_casa.pub";
      mode = "0644";
    };

    secrets."ssh_keys/khor_linux_default_pem/priv" = {
      path = "${config.home.homeDirectory}/.ssh/khor-linux-default.pem";
      mode = "0600";
    };

    secrets."ssh_keys/meulote_kp_pem/priv" = {
      path = "${config.home.homeDirectory}/.ssh/meulote-kp.pem";
      mode = "0600";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
