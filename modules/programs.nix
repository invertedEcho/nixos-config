{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    git = {
      enable = true;
      config = { push.autoSetupRemote = true; };
    };
    fish.enable = true;

    adb.enable = true;
  };
}
