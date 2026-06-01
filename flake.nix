{
  description = "Camofox browser automation server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      camofox = pkgs.buildNpmPackage {
        pname = "camofox-browser";
        version = "1.11.2";
        src = ./.;
        npmDepsHash = "sha256-FDecut8Gsy2pHrHRzpGf1Xw1Uvzjtaoq6JUhAyTUQsA=";

        # Build logic
        npmBuildScript = "build";
        npmFlags = [ "--ignore-scripts" ];

        # Ensure dependencies are available
        dontNpmBuild = false;

        # Needs nodejs 22
        nodejs = pkgs.nodejs_22;
      };
    in
    {
      packages.${system}.default = camofox;

      nixosModules.default =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        with lib;
        let
          cfg = config.services.camofox-browser;
        in
        {
          options.services.camofox-browser = {
            enable = mkEnableOption "Camofox browser automation server";
            host = mkOption {
              type = types.str;
              default = "0.0.0.0";
            };
            port = mkOption {
              type = types.int;
              default = 9377;
            };
            settings = mkOption {
              type = types.attrsOf types.str;
              default = { };
              description = "Environment variables to configure camofox-browser";
            };
          };

          config = mkIf cfg.enable {
            systemd.services.camofox-browser = {
              wantedBy = [ "multi-user.target" ];
              after = [ "network.target" ];
              serviceConfig = {
                ExecStart = "${camofox}/bin/camofox-browser";
                Environment = mapAttrsToList (k: v: "${k}=${v}") cfg.settings ++ [
                  "CAMOFOX_PORT=${toString cfg.port}"
                  "CAMOFOX_HOST=${cfg.host}"
                ];
                DynamicUser = true;
                StateDirectory = "camofox";
              };
            };
          };
        };
    };
}
