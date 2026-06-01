{
  config,
  lib,
  pkgs,
  ...
}:
{
  description = "NixOS module for Camofox Browser service";

  options = {
    services.camofox = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the Camofox Browser service.";
      };

      port = lib.mkOption {
        type = lib.types.int;
        default = 9377;
        description = "Port for the Camofox Browser service to listen on.";
      };

      host = lib.mkOption {
        type = lib.types.str;
        default = "0.0.0.0";
        description = "Host for the Camofox Browser service to bind to.";
      };
    };
  };

  config = {
    services.systemd.services.camofox-browser = {
      enable = config.services.camofox.enable;
      type = "simple";
      port = config.services.camofox.port;
      host = config.services.camofox.host;
      preStart = ''
        mkdir -p /var/log/camofox
      '';
      script = ''
        ${config.system.build.camofox}/bin/camofox-browser --host ${config.services.camofox.host} --port ${config.services.camofox.port}
      '';
      environment = {
        NODE_ENV = "production";
      };
      restart = "always";
    };
  };
}
