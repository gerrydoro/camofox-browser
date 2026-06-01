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
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        version = "1.11.2";
        camofox-browser = pkgs.stdenv.mkDerivation {
          pname = "camofox-browser";
          inherit version;
          src = ./.;
          nativeBuildInputs = with pkgs; [
            nodejs
            npm
          ];
          buildInputs = with pkgs; [ ];
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
          meta = {
            description = "Headless browser automation server and OpenClaw plugin for AI agents";
            homepage = "https://github.com/jo-inc/camofox-browser";
            license = licenses.mit;
            maintainers = with maintainers; [ ];
            mainProgram = "camofox-browser";
          };
        };
      in
      {
        packages.camofox-browser = camofox-browser;
      }
    );
}
