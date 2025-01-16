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
    inputs.zen-browser.packages."${system}".default
    inputs.ghostty.packages."${system}".default
    unstable.cmake

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
    openvpn3

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
