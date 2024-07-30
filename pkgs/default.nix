# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs, ...}: {
  vue-typescript-plugin = pkgs.callPackage ./vue-typescript-plugin {};
}
