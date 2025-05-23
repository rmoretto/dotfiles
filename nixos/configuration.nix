# This is your system's configuration file.configura
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./pipewire-rnn.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # overlays = [
    # Add overlays your own flake exports (from overlays and pkgs dir):
    # outputs.overlays.additions
    # outputs.overlays.modifications

    # You can also add overlays exported from other flakes:
    # neovim-nightly-overlay.overlays.default

    # Or define it inline, for example:
    # (final: prev: {
    #   hi = final.hello.overrideAttrs (oldAttrs: {
    #     patches = [ ./change-hello-to-hi.patch ];
    #   });
    # })
    # ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flakeconf.nix
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking.hostName = "rodrigo-pc";
  networking.networkmanager.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      # efiInstallAsRemovable = true;
    };
  };

  boot.supportedFilesystems = ["ntfs"];
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # security.pam.services.lightdm.enableGnomeKeyring = true;
  # security.pam.services.gdm.enableGnomeKeyring = true;
  # security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  security = {
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
  };

  # Enable the X11 windowing system.
  # services.xserver.videoDrivers = ["nvidia"];
  # services.xserver.layout = "us";
  # services.xserver.xkbVariant = "intl";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.unstable.hyprland;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # package = pkgs.hyprland.override { debug = true; };
  };


  # services.xserver.videoDrivers = ["nvidia"];
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        # command = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        user = "rmoretto";
      };
      default_session = initial_session;
    };
  };

  # services.xserver = {
  #   enable = true;
  #   videoDrivers = ["nvidia"];
  #   exportConfiguration = true;
  #   displayManager.gdm = {
  #     enable = true;
  #     wayland = true;
  #   };
  #   xkb = {
  #     layout = "us";
  #     variant = "intl";
  #   };
  # };

  # services.displayManager = {
  #   autoLogin.user = "rmoretto";
  #   defaultSession = "none+i3";
  # };

  # services.xserver = {
  #   enable = true;
  #   videoDrivers = ["nvidia"];
  #   displayManager = {
  #     lightdm.enable = true;
  #   };
  #   windowManager.i3.enable = true;
  #   xkb = {
  #     layout = "us";
  #     variant = "intl";
  #   };
  #   exportConfiguration = true;
  # };

  services.xserver.displayManager.setupCommands = ''
    LEFT='DP-2'
    CENTER='DP-4'
    RIGHT='DP-0'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --mode 1920x1080 --pos 3840x0 --rotate right \
           --output $LEFT --mode 1920x1080 --pos 0x478 --rotate normal \
           --output $CENTER --primary --mode 1920x1080 --pos 1920x478 --rotate normal --rate 143.98
  '';

  # boot.kernelPackages = pkgs.unstable.linuxPackages_6_8;
  boot.kernelPackages = pkgs.unstable.linuxPackages_zen;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    # powerManagement.enable = false;
    # powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidia_x11_beta;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # package = config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs (old: {
    #   postPatch = ''
    #     substituteInPlace ./kernel/nvidia-drm/nvidia-drm-drv.c --replace \
    #       '#if defined(NV_SYNC_FILE_GET_FENCE_PRESENT)' \
    #       '#if 0'
    #   '';
    # });
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.blueman.enable = true;

  programs.noisetorch.enable = true;

  hardware.keyboard.qmk.enable = true;
  environment.etc."ppp/options".text = "ipcp-accept-remote";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.variables = {
    SHELL = "fish";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    git
    wget
    curl
    vim
    home-manager
    polkit_gnome
    gnome-keyring
    kitty
    lxqt.lxqt-policykit
  ];

  programs.fish.enable = true;

  users.users = {
    rmoretto = {
      initialPassword = "1234";
      isNormalUser = true;
      description = "zequinha d vdd";
      shell = pkgs.fish;
      extraGroups = ["networkmanager" "wheel" "docker"];
      packages = with pkgs; [
        firefox
        git
        wget
        curl
        vim
      ];
    };
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  #   config.common.default = "gtk";
  # };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "hyprland";
  };

  services.flatpak.enable = true;

  services.davfs2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  services.spice-vdagentd.enable = true;
  virtualisation.docker.enable = true;

  programs.openvpn3.enable = true;
  programs.ssh.startAgent = true;
  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  systemd = {
    # user.services.polkit-gnome-authentication-agent-1 = {
    #   description = "polkit-gnome-authentication-agent-1";
    #   wantedBy = ["graphical-session.target"];
    #   wants = ["graphical-session.target"];
    #   after = ["graphical-session.target"];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #     TimeoutStopSec = 10;
    #   };
    # };
    #
    # user.services.gnome-keyring = {
    #   description = "GNOME Keyring";
    #   wantedBy = [ "graphical-session-pre.target" ];
    #   wants = ["graphical-session.target"];
    #   after = ["graphical-session.target"];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --foreground";
    #     Restart = "on-abort";
    #   };
    # };
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
