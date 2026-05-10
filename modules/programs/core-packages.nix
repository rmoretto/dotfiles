{
  flake.modules.nixos.core-packages = {pkgs, ...}: {
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
  };
}
