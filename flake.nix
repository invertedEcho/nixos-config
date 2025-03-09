{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    ...
  }: {
    darwinConfigurations = {
      macbook = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/common/apps.nix
          ./modules/darwin/index.nix
          ./modules/darwin/apps.nix
        ];
      };
    };

    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem {
        system = "x86-64-linux";
        modules = [
          ./modules/linux/configuration.nix
          ./hosts/home-pc.nix
          ./modules/linux/game.nix
          ./modules/common/apps.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/linux/home.nix;
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
          ./modules/linux/configuration.nix
          ./hosts/work-laptop.nix
          ./modules/common/apps.nix

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
          ./modules/linux/configuration.nix
          ./hosts/macbook-vm.nix
          ./modules/common/apps.nix

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
