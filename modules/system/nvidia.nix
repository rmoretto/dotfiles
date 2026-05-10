{
  flake.modules.nixos.nvidia = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.opengl.enable = true;
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = false;
    };

    # hardware.nvidia-container-toolkit.enable = true;
  };
}
