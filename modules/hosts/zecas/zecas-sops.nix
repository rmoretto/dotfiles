{inputs, ...}: {
  flake-file.inputs = {
    sops-nix.url = "github:mic92/sops-nix";
  };

  flake.modules.homeManager.rmoretto-sops = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      inputs.sops-nix.homeManagerModule
    ];

    home.packages = with pkgs; [
      sops
    ];

    sops = {
      age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
      defaultSopsFile = ../../../secrets/common/secrets.yaml;
    };
  };
}
