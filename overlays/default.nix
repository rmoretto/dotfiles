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
    # godot_4 = prev.godot_4.overrideAttrs (oldAttrs: rec {
    #   version = "4.2.1-stable";
    #   commitHash = "b09f793f564a6c95dc76acc654b390e68441bd01";
    #
    #   src = prev.fetchFromGitHub {
    #     owner = "godotengine";
    #     repo = "godot";
    #     rev = commitHash;
    #     hash = "sha256-Q6Og1H4H2ygOryMPyjm6kzUB6Su6T9mJIp0alNAxvjQ=";
    #   };
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
