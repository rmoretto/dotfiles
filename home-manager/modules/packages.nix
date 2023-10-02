{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Very Fun and games
    firefox
    google-chrome
    chromium
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
    gnome.gnome-disk-utility
    sl
    neofetch
    cmatrix
    libnotify
    gnome.seahorse
    gparted
    flameshot
    gzip
    # gnome.nautilus
    # libsForQt5.ark
    ntfs3g
    feh
    
    # soundsss and VIDEOS
    pavucontrol
    alsa-utils
    vlc

    # networking
    openfortivpn
    networkmanagerapplet

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
      python3-with-packages = pkgs.python3.withPackages (p:
        with p; [
          pip
          pynvim
          setuptools
        ]);
    in
      python3-with-packages)
    jetbrains.pycharm-professional
    docker-compose
    postgresql_13

    # Fonts
    nerdfonts
    jetbrains-mono
    iosevka
    iosevka-bin
    siji
    termsyn
    material-icons
    material-design-icons
    terminus_font
    terminus-nerdfont
    fantasque-sans-mono
    noto-fonts
    papirus-icon-theme
    font-awesome
  ];

}
