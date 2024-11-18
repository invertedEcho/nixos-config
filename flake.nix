{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem {
        system = "x86-64-linux";
        modules = [
          ./configuration.nix
          ./hardware/home-pc.nix
          ./modules/game.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/home.nix;
              backupFileExtension = "old.bak";
            };
          }
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = "x86_64-linux";
                  config = {allowUnfree = true;};
                };
              })
            ];
          }
        ];
      };
      work-laptop = nixpkgs.lib.nixosSystem {
        system = "x86-64-linux";
        modules = [
          ./configuration.nix
          ./hardware/work-laptop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/home.nix;
              backupFileExtension = "old.bak";
            };
          }
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = "x86_64-linux";
                  config = {allowUnfree = true;};
                };
              })
            ];
          }
        ];
      };
      macbook-vm = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./configuration.nix
          ./hardware/macbook-vm.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/home.nix;
              backupFileExtension = "old.bak";
            };
          }
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = "aarch64-linux";
                  config = {allowUnfree = true;};
                };
              })
            ];
          }
        ];
      };
    };
  };
}
