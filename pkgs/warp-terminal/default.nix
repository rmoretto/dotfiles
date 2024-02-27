{ lib
, stdenv
, fetchurl

, autoPatchelfHook
, dpkg
, makeWrapper
, undmg
, wrapGAppsHook

, gcc
, libgcc
, fontconfig
, curl
, libpng
, zlib
, xorg
, libxkbcommon
, wayland
, libGL
}:

  # meta = {
  #   description = "An open source, cross-platform Spotify client compatible across multiple platforms";
  #   longDescription = ''
  #     Spotube is an open source, cross-platform Spotify client compatible across
  #     multiple platforms utilizing Spotify's data API and YouTube (or Piped.video or JioSaavn)
  #     as an audio source, eliminating the need for Spotify Premium
  #   '';
  #   downloadPage = "https://github.com/KRTirtho/spotube/releases";
  #   homepage = "https://spotube.netlify.app/";
  #   license = lib.licenses.bsdOriginal;
  #   mainProgram = "spotube";
  #   maintainers = with lib.maintainers; [ tomasajt ];
  #   platforms = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
  #   sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  # };

stdenv.mkDerivation rec {
  pname = "warp-terminal";
  version = "0.2024.02.20.08.01.stable_02";

  src = fetchurl {
    url = "https://releases.warp.dev/stable/v0.2024.02.20.08.01.stable_02/warp-terminal_0.2024.02.20.08.01.stable.02_amd64.deb";
    hash = "sha256-F0CfKTtgHOoeJienFAoqdYKV/0ZTsC1GhzOeQFl3oDk=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];

  buildInputs = [
    gcc
    libgcc
    fontconfig
    curl
    stdenv.cc.cc
    libpng
    zlib
  ];

  runtimeDependencies = [
    libxkbcommon
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    libGL
  ];

  unpackPhase = ''
    mkdir pkg
    dpkg-deb -x $src pkg

    sourceRoot=pkg
  '';

  installPhase = ''
    echo "--- usr"

    mkdir -p $out/{bin,share}
    mv usr/share/* $out/share
    mv opt/warpdotdev/warp-terminal $out/bin/warp-terminal

    # mkdir -p $out/share/applications
    # mv $out/share/wapr-terminal.desktop $out/share/applications

    mv dev.warp.Warp.desktop Warp.desktop

    # substituteInPlace $out/share/applications/Warp.desktop \
    #   --replace "/usr/local/bin/warp-terminal" "warp-terminal" \
    #   --replace "/opt/tableplus/resource/image/logo.png" "$out/share/resource/image/logo.png"
  '';

  # preFixup = ''
  #   patchelf $out/share/spotube/lib/libmedia_kit_native_event_loop.so \
  #       --replace-needed libmpv.so.1 libmpv.so
  # '';

  # postFixup = ''
  #   makeWrapper $out/share/warp-terminal/warp $out/bin/warp-terminal
  #       # "''${gappsWrapperArgs[@]}" \
  #       # --prefix LD_LIBRARY_PATH : $out/share/warp-termianl/lib:${lib.makeLibraryPath [ mpv-unwrapped ]} \
  #       # --prefix PATH : ${lib.makeBinPath [ xdg-user-dirs ]}
  # '';
}

