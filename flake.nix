{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nix-flatpak,
    ...
  }: {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "home-pc";
        };
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./hosts/home-pc.nix
          ./modules/configuration.nix
          ./modules/applications/all.nix
          ./modules/applications/desktop-apps.nix
          ./modules/applications/programs.nix
          ./modules/applications/firefox.nix
          ./modules/game.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/virtualisation.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/hamachi.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/easier-life-on-nix.nix
          ./modules/flatpak.nix

          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = "x86_64-linux";
                  config = {allowUnfree = true;};
                };

                ddcutil = prev.ddcutil.overrideAttrs (old: {
                  version = "2.2.5";

                  src = prev.fetchurl {
                    url = "https://www.ddcutil.com/tarballs/ddcutil-2.2.5.tar.gz";
                    hash = "sha256-eV6uVI1JYR6YnNSQRq/1jZLheSwNq7Zz7Su9Ab1PH48=";
                  };
                });
              })
            ];
          }
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "thinkpad";
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
      vm = nixpkgs.lib.nixosSystem {
        system = "x86-64-linux";
        specialArgs = {
          inherit inputs;
          hostId = "vm";
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
