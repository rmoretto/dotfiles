# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev: import ../pkgs {pkgs = inputs.nixpkgs-unstable.legacyPackages.${prev.system};};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    notifd = inputs.notifd.packages.${prev.system}.default;
    xwaylandvideobridge = prev.xwaylandvideobridge.overrideAttrs (oldAttrs: rec {
      version = "0.4.0";

      src = prev.fetchFromGitLab {
        domain = "invent.kde.org";
        owner = "system";
        repo = "xwaylandvideobridge";
        rev = "v${version}";
        hash = "sha256-DzNJxZbSdhqdtIQvQ7ZKrKwu6zTcBjtsR9rv/uudZcw=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
