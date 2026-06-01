{ lib, pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "camofox-browser";
  version = "1.11.2";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    nodejs
    npm
  ];

  buildInputs = with pkgs; [
    nodejs
    python3
    xvfb-run
    xorg.xf86videomode
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXtst
    xorg.libXcursor
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libxkbfile
    xorg.libxshmfence
    xorg.libXxf86vm
    xorg.libXi
    xorg.libSM
    xorg.libICE
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    cups
    dbus
    expat
    libdrm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    gtk3
    gdk-pixbuf
    glib
    libnotify
    libpulseaudio
    libuuid
    libva
    libvpx
    pciutils
    pipewire
    libGL
    vulkan-loader
    wayland
  ];

  buildPhase = ''
    runHook preBuild
    export HOME=$(mktemp -d)
    npm install --production
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib/camofox-browser
    cp -r . $out/lib/camofox-browser/camofox-browser
    runHook postInstall
  '';

  meta = with lib; {
    description = "Headless browser automation server and OpenClaw plugin for AI agents";
    homepage = "https://github.com/jo-inc/camofox-browser";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "camofox-browser";
  };
}
