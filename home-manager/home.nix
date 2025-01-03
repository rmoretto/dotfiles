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
    ./modules/packages.nix

    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/rofi.nix
    ./modules/ssh.nix
    ./modules/terminal.nix
    ./modules/tmux.nix
    ./modules/window_manager.nix
    # ./modules/hyprland.nix
    ./modules/i3.nix
    ./modules/picom.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "rmoretto";
    homeDirectory = "/home/rmoretto";
  };

  systemd.user.services.notifd = {
    Unit = {
      Description = "NotifD - Notification Watcher Service";
    };

    Service = {
      ExecStart = "${pkgs.notifd}/bin/notifd run";
      KillSignal = "SIGKILL";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
