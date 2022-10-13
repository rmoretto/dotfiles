# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule
  
    # Feel free to split up your configuration and import pieces of it here.
  ];

  home = {
    username = "rodrigo";
    homeDirectory = "/home/rodrigo";
  };

  # Enable install fonts with home.packages
  fonts.fontconfig.enable = true;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    vim
    curl
    wget
    git
    alacritty
    tmux
    htop
    ncdu
    unzip
    jq
    firefox
    spotify
    discord
    flatpak
    ranger
    polybar
    rofi
    dunst
    picom
    vscode
    go
    gcc
    cargo
    rustc
    nodejs
    ripgrep
    fd
    (let
      python3-with-packages = pkgs.python3.withPackages(p: with p; [
        pynvim
        setuptools
      ]);
    in
    python3-with-packages)
    nerdfonts
    awesome
    lua
    pulseaudio
  ];

  # xsession.windowManager.i3 = {
  #   enable = true;
  #   package = pkgs.i3-gaps;
  # };

  # xsession.windowManager.awesome = {
  #   enable = true;
  # };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.starship.enable = true;
  # programs.flatpak.enable = true;

  programs.git = {
    enable = true;
    aliases = {
      s = "status";
      a = "add";
      c = "commit";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    plugins = (with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.tilish;
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ]);
    extraConfig = ''
    # Improve colors
    set -g default-terminal tmux-256color
    set -ga terminal-overrides ",xterm-256color:RGB"
    
    # Vim options
    set-option -sg escape-time 10
    set-option -g focus-events on
    
    # Mouse show
    set-option -g mouse on
    
    # make scrolling with wheels work
    bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
    bind -n WheelDownPane select-pane -t= \; send-keys -M
    
    # Vi like pase support
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"
    '';
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {
    # -- Neovim
    ".config/nvim" = {
      source = ../configs/nvim;
      recursive = true;
    };

    # -- Alacritty
    ".config/alacritty" = {
      source = ../configs/alacritty;
      recursive = true;
    };

    # -- Tmux
    # ".tmux.conf" = {
    #   source = ../configs/tmux/.tmux.conf;
    # };

    # -- i3
    ".config/i3" = {
      source = ../configs/i3;
      recursive = true;
    };

    ".config/awesome" = {
      source = ../configs/awesome;
      recursive = true;
    };

    # -- Polybar
    ".config/polybar" = {
      source = ../configs/polybar;
      recursive = true;
    };

    # -- Rofi
    ".config/rofi" = {
      source = ../configs/rofi;
      recursive = true;
    };

    # -- Starship
    ".config/starship.toml" = {
      source = ../configs/starship/starship.toml;
    };

    # -- Ranger
    ".config/ranger" = {
      source = ../configs/ranger;
      recursive = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}

