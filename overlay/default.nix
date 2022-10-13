# This file defines two overlays and composes them
{ inputs, ... }:
let
  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    awesome = prev.awesome.overrideAttrs (oldAttrs: rec {
      src = prev.fetchFromGitHub {
        owner = "awesomewm";
        repo = "awesome";
        rev = "4a140ea5ea681e7a0f62d8ef050b0ed1b905cc68";
        sha256 = "38077cc84715b08870c20cbc9369833f66210786087d081a867d93f668e42e43";
      };

      patches = [];
      patchPhase = ''
      patchShebangs ./tests
      '';
    });
  };
in
# inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
inputs.nixpkgs.lib.composeManyExtensions [ modifications ]

