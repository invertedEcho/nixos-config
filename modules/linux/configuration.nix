{
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos-invertedecho";
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.echo = {
    isNormalUser = true;
    extraGroups = ["wheel" "kvm" "adbusers" "libvirtd" "gamemode"];
    shell = pkgs.zsh;
    # we dont need a password in a vm guest since host already has a password.
    # TODO: use hostname instead of system architecture
    hashedPassword =
      if pkgs.system != "aarch64-linux"
      then "$y$j9T$.hLn6L5LbKZMtv1xvzkJS0$xMp9N3vCFRp6KgIV2HcH9aXxEQzRVARk09.inWoiLl5"
      else "";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # enable ozone wayland support for electron based applications
    PKG_CONFIG_PATH = "${pkgs.openssl}/lib/pkgconfig/"; # fix some packages not finding openssl lib
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.permittedInsecurePackages = ["electron-24.8.6"];

  networking.wireless.iwd.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.polkit.enable = true;
  # TODO: i think starting hyprland manually does not trigger the graphical-session.target
  # also starting manually from hyprland exec-once, so this is probably stupid
  # TODO: check if this is even needed anymore for screenshare to work
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

  boot = {
    kernelParams = ["quiet" "loglevel=3"];
    binfmt =
      if (pkgs.system != "aarch64-linux")
      then {
        preferStaticEmulators = true;
        emulatedSystems = ["aarch64-linux"];
      }
      else {};
    loader.grub = {
      theme = pkgs.sleek-grub-theme.override {withStyle = "dark";};
    };
  };

  time.hardwareClockInLocalTime = true;
  system.stateVersion = "23.11";
}
