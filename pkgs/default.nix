# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  forticlient = pkgs.callPackage ./forticlient {};
  min-ed-launcher = pkgs.callPackage ./min-ed-launcher {};
}
