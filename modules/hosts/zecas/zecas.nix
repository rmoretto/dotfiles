{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.rmoretto = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.rmoretto-hardware
      self.modules.nixos.rmoretto
    ];
  };

  flake.modules.nixos.rmoretto-system = {
    imports = [
      self.modules.nixos.nix-settings
      self.modules.nixos.boot
      self.modules.nixos.locale
      self.modules.nixos.nvidia
      self.modules.nixos.pipewire
      self.modules.nixos.swapfile
    ];

    hardware.i2c.enable = true;
    hardware.keyboard.qmk.enable = true;
  };

  flake.modules.nixos.rmoretto-programs = {pkgs, ...}: {
    imports = [
      self.modules.nixos.core-packages

      self.modules.nixos.rmoretto-packages

      self.modules.nixos.fortclient
      self.modules.nixos.git
      self.modules.nixos.ssh

      self.modules.nixos.nvim
      self.modules.nixos.fish
      self.modules.nixos.kitty
      self.modules.nixos.tmux

      self.modules.nixos.hyprland
    ];
  };

  flake.modules.nixos.rmoretto = {
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.default

      self.modules.nixos.rmoretto-system
      self.modules.nixos.rmoretto-programs
    ];

    users.users.rmoretto = {
      initialPassword = "1234";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "docker" "libvirtd" "i2c"];
      shell = pkgs.fish;
    };

    system.stateVersion = "25.11";

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
    home-manager.backupCommand = "rm";
    home-manager.overwriteBackup = true;

    home-manager.users.rmoretto = {
      home = {
        username = "rmoretto";
        stateVersion = "25.11";
        homeDirectory = "/home/rmoretto";
      };

      systemd.user.startServices = "sd-switch";
    };
  };
}
