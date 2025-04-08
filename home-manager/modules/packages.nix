{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Very Fun and games
    unstable.firefox
    unstable.google-chrome
    chromium
    spotify
    discord
    vesktop
    bitwarden
    # warp-terminal
    unstable.terminaltexteffects
    joplin-desktop
    unstable.cmake
    libreoffice

    # rofi-wayland
    waybar
    wl-gammactl
    wl-clipboard
    wf-recorder
    wlprop
    hyprpicker
    wayshot
    swappy
    grim
    slurp
    imagemagick
    swww
    easyeffects

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
    eza
    xcowsay
    xclip
    gnome-disk-utility
    sl
    neofetch
    cmatrix
    libnotify
    seahorse
    gparted
    unstable.flameshot
    gzip
    # gnome.nautilus
    # libsForQt5.ark
    ntfs3g
    feh
    notifd
    file-roller
    gnome-calendar
    btop
    woeusb
    efibootmgr
    steam
    steam-run
    # wine
    wineWowPackages.stable
    winetricks
    lutris
    xwaylandvideobridge
    ffmpeg
    lolcat
    unetbootin
    sd
    sad
    dig

    # soundsss and VIDEOS
    pavucontrol
    alsa-utils
    vlc
    mpv
    obs-studio

    # networking
    openfortivpn
    networkmanagerapplet

    # very cool code kid0
    vim
    nano
    vscode
    rustup
    # cargo
    rustc
    # rust-analyzer
    # marksman
    go
    gcc
    lua
    nodejs
    sassc
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
          python-pam
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
    difftastic
    stylua
    gnumake
    awscli2
    git-filter-repo
    nix-your-shell
    gh

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
