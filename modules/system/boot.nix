{
  flake.modules.nixos.boot = {
    pkgs,
    config,
    ...
  }: {
    boot.kernelPackages = pkgs.linuxPackages_6_12;

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        # efiInstallAsRemovable = true;
      };
    };

    boot.supportedFilesystems = ["ntfs"];
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
      universal-pidff
    ];

    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
