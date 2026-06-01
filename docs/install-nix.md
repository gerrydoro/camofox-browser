# Installing Camofox with Nix

To use Camofox as a Nix flake, add it to your `flake.nix` inputs:

```nix
{
  inputs = {
    camofox.url = "github:jo-inc/camofox-browser";
  };
  
  outputs = { self, nixpkgs, camofox }: {
    nixosConfigurations.my-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        camofox.nixosModules.default
        {
          services.camofox-browser = {
            enable = true;
            host = "0.0.0.0";
            port = 9377;
            settings = {
              NODE_ENV = "production";
            };
          };
        }
      ];
    };
  };
}
```

After adding the module, run `nixos-rebuild switch`.
