{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
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
          ./modules/applications/programs.nix
          ./modules/applications/spicetify.nix
          ./modules/applications/firefox.nix
          ./modules/game.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/vm.nix
          ./modules/xdg.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/hamachi.nix
          ./modules/audio.nix
          ./modules/networking.nix
          inputs.spicetify-nix.nixosModules.default

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
          ./modules/applications/spicetify.nix
          ./modules/applications/firefox.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/xdg.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/audio.nix
          ./modules/networking.nix
          inputs.spicetify-nix.nixosModules.default

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
        ];
      };
    };
  };
}
