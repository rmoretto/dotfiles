{inputs, ...}: {
  flake-file.inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  flake.overlays = {
    unstable-packages = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    };

    modifications = final: prev: {
      obs-studio = prev.obs-studio.overrideAttrs (oldAttrs: {
        # extend old postInstall (if exists) with wrapProgram
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            wrapProgram $out/bin/obs --set __NV_DISABLE_EXPLICIT_SYNC 1
          '';
      });
    };
  };
}
