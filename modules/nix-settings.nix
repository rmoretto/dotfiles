{self, ...}: {
  flake.modules.nixos.nix-settings = {
    nixpkgs.config.allowUnfree = true;

    nixpkgs = {
      overlays = [
        self.overlays.unstable-packages
        self.overlays.modifications
      ];
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
  };
}
