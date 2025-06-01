{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config.url = "github:invertedEcho/nvim-config";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    plasma-manager,
    ...
  }: {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem rec {
        system = "x86-64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/home-pc.nix
          ./modules/linux/apps.nix
          ./modules/linux/configuration.nix
          ./modules/linux/game.nix
          ./modules/linux/programs.nix
          ./modules/linux/services.nix
          ./modules/linux/virtualisation.nix
          ./modules/linux/xdg.nix
          ./modules/common/apps.nix
          ./modules/linux/desktop-environments/plasma.nix
          ./modules/linux/hamachi.nix
          ./modules/linux/apps/communication.nix
          ./modules/linux/apps/entertainment.nix
          ./modules/linux/audio.nix
          inputs.spicetify-nix.nixosModules.default
          ./modules/linux/apps/spicetify.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/linux/home.nix;
              backupFileExtension = "old.bak";
              extraSpecialArgs = specialArgs;
              sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
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
          ./hosts/macbook-vm.nix
          ./modules/linux/apps.nix
          ./modules/linux/configuration.nix
          ./modules/linux/programs.nix
          ./modules/linux/services.nix
          ./modules/linux/xdg.nix
          ./modules/common/apps.nix
          ./modules/linux/window-managers/i3.nix

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
                  system = "aarch64-linux";
                  config = {allowUnfree = true;};
                };
              })
            ];
          }
        ];
      };
    };
    darwinConfigurations = {
      macbook = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/common/apps.nix
          ./modules/darwin/index.nix
          ./modules/darwin/apps.nix

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.invertedecho = import ./modules/darwin/home.nix;
            };
            users.users.invertedecho.home = "/Users/invertedecho";
          }
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = "aarch64-darwin";
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
