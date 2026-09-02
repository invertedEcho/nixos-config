{
  description = "invertedEcho's NixOS Configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-flatpak,
    ...
  }: {
    nixosConfigurations = {
      home-pc = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostId = "home-pc";
        };
        modules = [
          ./hosts/home-pc.nix
          ./modules/configuration.nix
          ./modules/applications/full.nix
          ./modules/applications/by-host/home-pc.nix
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
          ./modules/razer.nix
          nix-flatpak.nixosModules.nix-flatpak
          ./modules/flatpak.nix
          (import ./overlays)
          ./modules/teamviewer.nix
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostId = "thinkpad";
        };
        modules = [
          ./hosts/thinkpad.nix
          ./modules/configuration.nix
          ./modules/applications/full.nix
          ./modules/applications/by-host/thinkpad.nix
          ./modules/applications/programs.nix
          ./modules/applications/firefox.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/window-managers/hyprland.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/easier-life-on-nix.nix
          (import ./overlays)
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostId = "vm";
        };
        modules = [
          ./hosts/vm.nix
          ./modules/configuration.nix
          ./modules/applications/base.nix
          ./modules/applications/programs.nix
          ./modules/applications/firefox.nix
          ./modules/services.nix
          ./modules/docker.nix
          ./modules/window-managers/hyprland.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/hamachi.nix
          ./modules/audio.nix
          ./modules/networking.nix
          ./modules/easier-life-on-nix.nix
          (import ./overlays)
        ];
      };
    };
  };
}
