{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModule
  ];

  home.file.".ssh/config" = {
    source = ../../configs/ssh/config;
  };

  sops = {
    age.sshKeyPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519"];
    defaultSopsFile = ../../secrets/common/secrets.yaml;

    secrets."ssh_keys/cbti/priv" = {
      path = "${config.home.homeDirectory}/.ssh/cbti";
      mode = "0600";
    };
    secrets."ssh_keys/cbti/pub" = {
      path = "${config.home.homeDirectory}/.ssh/cbti.pub";
      mode = "0644";
    };

    secrets."ssh_keys/ciasc_root/priv" = {
      path = "${config.home.homeDirectory}/.ssh/ciasc_root";
      mode = "0600";
    };
    secrets."ssh_keys/ciasc_root/pub" = {
      path = "${config.home.homeDirectory}/.ssh/ciasc_root.pub";
      mode = "0644";
    };

    secrets."ssh_keys/flowtify_pem/priv" = {
      path = "${config.home.homeDirectory}/.ssh/flowtify.pem";
      mode = "0600";
    };

    secrets."ssh_keys/google_compute_engine/priv" = {
      path = "${config.home.homeDirectory}/.ssh/google_compute_engine";
      mode = "0600";
    };
    secrets."ssh_keys/google_compute_engine/pub" = {
      path = "${config.home.homeDirectory}/.ssh/google_compute_engine.pub";
      mode = "0644";
    };

    secrets."ssh_keys/id_rsa/priv" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa";
      mode = "0600";
    };
    secrets."ssh_keys/id_rsa/pub" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
      mode = "0644";
    };

    secrets."ssh_keys/id_rsa_casa/priv" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa_casa";
      mode = "0600";
    };
    secrets."ssh_keys/id_rsa_casa/pub" = {
      path = "${config.home.homeDirectory}/.ssh/id_rsa_casa.pub";
      mode = "0644";
    };

    secrets."ssh_keys/khor_linux_default_pem/priv" = {
      path = "${config.home.homeDirectory}/.ssh/khor-linux-default.pem";
      mode = "0600";
    };

    secrets."ssh_keys/meulote_kp_pem/priv" = {
      path = "${config.home.homeDirectory}/.ssh/meulote-kp.pem";
      mode = "0600";
    };
  };
}
