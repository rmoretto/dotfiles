{
  flake.modules.nixos.mounts = {
    ...
  }: {
    fileSystems."/mnt/win" = {
      device = "/dev/disk/by-uuid/EC4C3E774C3E3D20";
      fsType = "ntfs3";
      options = [
        "rw" "uid=1000" "gid=100" "umask=022"
        "iocharset=utf8" "windows_names"
        "nofail" "x-systemd.device-timeout=5s"
      ];
    };
  };
}
