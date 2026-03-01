{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:invertedEcho/dotfiles";
      flake = false;
    };
    nvim-config = {
      url = "github:invertedEcho/nvim-config";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    dotfiles,
    nvim-config,
    ...
  }: {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem rec {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "home-pc";
          dotfiles = dotfiles;
          nvim-config = nvim-config;
        };
        modules = [
          ./hosts/home-pc.nix
          ./modules/configuration.nix
          ./modules/applications/all.nix
          ./modules/applications/desktop-apps.nix
          ./modules/applications/programs.nix
          ./modules/applications/firefox.nix
          ./modules/game.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/vm.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/hamachi.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/easier-life-on-nix.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/home-manager/main.nix;
              backupFileExtension = "old.bak";
              extraSpecialArgs = specialArgs;
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
      thinkpad = nixpkgs.lib.nixosSystem rec {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "thinkpad";
          dotfiles = dotfiles;
          nvim-config = nvim-config;
        };
        modules = [
          ./hosts/thinkpad.nix
          ./modules/configuration.nix
          ./modules/applications/all.nix
          ./modules/applications/programs.nix
          ./modules/applications/firefox.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/easier-life-on-nix.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/home-manager/main.nix;
              backupFileExtension = "old.bak";
              extraSpecialArgs = specialArgs;
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
      vm = nixpkgs.lib.nixosSystem rec {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "vm";
          dotfiles = dotfiles;
          nvim-config = nvim-config;
        };
        modules = [
          ./hosts/vm.nix
          ./modules/configuration.nix
          ./modules/applications/all.nix
          ./modules/applications/programs.nix
          ./modules/applications/firefox.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/window-managers/hyprland.nix
          ./modules/hamachi.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/easier-life-on-nix.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.echo = import ./modules/home-manager/main.nix;
              backupFileExtension = "old.bak";
              extraSpecialArgs = specialArgs;
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
    };
  };
}
