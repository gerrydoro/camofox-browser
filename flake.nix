{
  description = "Nix flake for Camofox Browser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";

        # System dependencies from Dockerfile
        camofox-deps = with pkgs; [
          gtk3
          dbus-glib
          libxt6
          alsa-lib
          libx11-xcb
          libxcomposite
          libxcursor
          libxdamage
          libxfixes
          libxi
          libxrandr
          libxrender
          libxss
          libxtst
          mesa
          libglvnd
          libgbm
          xorg.xorgserver
          xvfb
          liberation-ttf
          noto-fonts-emoji
          freefont-ttf
          cacert
          curl
          unzip
          python3
          x11vnc
          novnc
          websockify
          nettools
          procps
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.npm
          ]
          ++ camofox-deps;

          shellHook = ''
            echo "Camofox Browser development environment"
            echo "To start the server, run: npm start"
            echo "To run tests, run: npm test"
          '';
        };
      }
    );
}
