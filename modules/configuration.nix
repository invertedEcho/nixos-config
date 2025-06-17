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
    hashedPassword = "$y$j9T$.hLn6L5LbKZMtv1xvzkJS0$xMp9N3vCFRp6KgIV2HcH9aXxEQzRVARk09.inWoiLl5";
  };

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    # TODO: Should also include previous PKG_CONFIG_PATH, if any set
    PKG_CONFIG_PATH = "${pkgs.openssl}/lib/pkgconfig/"; # fix some packages not finding openssl lib
    XCURSOR_THEME = "volantes_cursors";
    XCURSOR_SIZE = 30;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.polkit.enable = true;

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
}
