{
  pkgs,
  lib,
  ...
}: {
  # Modules that are used by all hosts
  imports = [
    ./agenix.nix
    ./theme.nix
    ./xdg.nix
  ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
    };
  };

  users.users.echo = {
    isNormalUser = true;
    extraGroups = ["wheel" "kvm" "adbusers" "libvirtd" "gamemode" "networkmanager" "i2c" "plugdev" "openrazer" "wireshark"];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$.hLn6L5LbKZMtv1xvzkJS0$xMp9N3vCFRp6KgIV2HcH9aXxEQzRVARk09.inWoiLl5";
  };

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  # fix issue nautilus show audio/video information on file in nautilus "gstreamer missing plugins" https://github.com/NixOS/nixpkgs/issues/195936
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = with pkgs.gst_all_1;
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.polkit.enable = true;

  hardware.logitech.wireless.enable = true;

  boot = {
    kernelParams = ["loglevel=4"];
    binfmt =
      if (pkgs.stdenv.hostPlatform.system != "aarch64-linux")
      then {
        preferStaticEmulators = true;
        emulatedSystems = ["aarch64-linux"];
      }
      else {};
  };

  time.hardwareClockInLocalTime = true;
}
