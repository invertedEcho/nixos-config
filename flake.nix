{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config.url = "github:invertedEcho/nvim-config";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem rec {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "home-pc";
        };
        modules = [
          ./hosts/home-pc.nix
          ./modules/apps.nix
          ./modules/configuration.nix
          ./modules/game.nix
          ./modules/programs.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/vm.nix
          ./modules/xdg.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/hamachi.nix
          ./modules/audio.nix
          inputs.spicetify-nix.nixosModules.default
          ./modules/spicetify.nix

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
        };
        modules = [
          ./hosts/thinkpad.nix
          ./modules/apps.nix
          ./modules/configuration.nix
          ./modules/programs.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/xdg.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/audio.nix
          inputs.spicetify-nix.nixosModules.default
          ./modules/spicetify.nix
          ./modules/game.nix

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
