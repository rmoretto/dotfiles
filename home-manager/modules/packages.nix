{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Very Fun and games
    firefox
    unstable.google-chrome
    chromium
    spotify
    discord
    steam
    lutris
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.proton-ge
    godot_4

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
    notifd
    gnome.file-roller
    gnome.gnome-calendar
    btop
    woeusb
    efibootmgr
    protontricks
    steam-run
    wine

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
    rustup
    # cargo
    # rustc
    # rust-analyzer
    marksman
    go
    gcc
    lua
    nodejs
    (let
      python3-with-packages = pkgs.python3.withPackages (p:
        with p; [
          pip
          black
          pillow
          dbus-python
          pygobject3
          pynvim
          setuptools
          psycopg2
        ]);
    in
      python3-with-packages)
    jetbrains.pycharm-professional
    docker-compose
    postgresql_13
    gdk-pixbuf
    gtk3
    terraform
    delta

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
