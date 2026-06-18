{self, ...}: {
  flake.modules.homeManager.rmoretto-packages = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs;
      [
        # Very Fun and games
        unstable.firefox
        unstable.google-chrome
        chromium
        unstable.spotify
        unstable.discord
        vesktop
        unstable.terminaltexteffects
        joplin-desktop
        unstable.cmake
        libreoffice
        github-desktop
        figma-linux
        boxflat
        whatsapp-electron

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
        easyeffects
        obs-studio
        gromit-mpx
        unstable.claude-code

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
        cmatrix
        libnotify
        seahorse
        gparted
        # unstable.flameshot
        (unstable.flameshot.override {enableWlrSupport = true;})
        gzip
        # gnome.nautilus
        # libsForQt5.ark
        ntfs3g
        feh
        file-roller
        gnome-calendar
        btop
        woeusb
        efibootmgr
        # wine
        wineWow64Packages.stable
        winetricks
        lutris
        ffmpeg
        lolcat
        unetbootin
        sd
        sad
        dig
        sbctl

        nvidia-container-toolkit
        nvidia-vaapi-driver

        # soundsss and VIDEOS
        pavucontrol
        alsa-utils
        vlc
        mpv

        # networking
        openfortivpn
        networkmanagerapplet

        # very cool code kid0
        vim
        nano
        vscode
        rustup
        rustc
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
        unstable.jetbrains.pycharm
        docker-compose
        gdk-pixbuf
        gtk3
        nomad
        terraform
        delta
        difftastic
        stylua
        gnumake
        awscli2
        git-filter-repo
        nix-your-shell
        gh
        qemu
        quickemu
        ddcutil

        # Fonts
        # nerdfonts
        jetbrains-mono
        iosevka
        iosevka-bin
        siji
        termsyn
        material-icons
        material-design-icons
        terminus_font
        nerd-fonts.terminess-ttf
        fantasque-sans-mono
        noto-fonts
        papirus-icon-theme
        font-awesome
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };

  flake.modules.nixos.rmoretto-packages = {pkgs, ...}: {
    home-manager.sharedModules = [
      self.modules.homeManager.rmoretto-packages
    ];

    services.flatpak.enable = true;
    services.davfs2.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    virtualisation.docker.enable = true;
    services.spice-vdagentd.enable = true;

    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "rmoretto" ];

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    programs.openvpn3.enable = true;
    # programs.ssh.startAgent = true;
    programs.dconf.enable = true;

    services.ollama = {
      package = pkgs.unstable.ollama;
      enable = true;
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666", TAG+="uaccess"
    '';
  };
}
