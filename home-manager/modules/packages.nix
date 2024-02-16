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
    godot_4

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
    brightnessctl
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
    steam-run
    wine
    xwaylandvideobridge

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

  xdg.desktopEntries = {
    discord = {
      categories = ["Application" "Network" "InstantMessaging"];
      exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
      genericName = "All-in-one cross-platform voice and text chat for gamers";
      icon="discord";
      mimeType = ["x-scheme-handler/discord"];
      name = "Discord";
      terminal = false;
      type = "Application";
    };
  };
}
