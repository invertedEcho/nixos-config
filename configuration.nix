{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./modules/apps.nix ./modules/services.nix ./modules/programs.nix];

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos-invertedecho";
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.echo = {
    isNormalUser = true;
    extraGroups = ["wheel" "kvm" "adbusers" "libvirtd"];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$kSZUSuNWFeX4o6GlPHxk20$Pcc5XjIXXCYGh/B4fqRK/zLsEYpRpRsiP9p5oLiFCC2";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # enable ozone wayland support for electron based applications
    PKG_CONFIG_PATH = "${pkgs.openssl}/lib/pkgconfig/"; # fix some packages not finding openssl lib
  };

  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["JetBrainsMono"];})];

  nixpkgs.config.permittedInsecurePackages = ["electron-24.8.6"];

  networking.wireless.iwd.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.polkit.enable = true;
  # TODO: i think starting hyprland manually does not trigger the graphical-session.target
  # also starting manually from hyprland exec-once, so this is probably stupid
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  nix.nixPath = ["nixpgks=${inputs.nixpkgs}"];

  system.stateVersion = "23.11";
}
