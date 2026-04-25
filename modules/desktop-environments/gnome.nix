{
  pkgs,
  lib,
  ...
}: {
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xserver = {
      enable = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
  };

  programs.dconf.profiles.user.databases = [
    {
      lockAll = false;
      settings = {
        "org/gnome/desktop/input-sources" = {
          xkb-options = ["compose:caps"];
        };
        "org/gnome/shell" = {
          enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com" "dash-to-panel@jderose9.github.com" "blur-my-shell@aunetx"];
        };
        "org/gnome/shell/extensions/dash-to-panel" = {
          group-apps = false;
          intellihide = true;
          trans-use-border = true;
          trans-border-width = lib.gvariant.mkInt32 1;
          trans-panel-opacity = 0.3;
          show-favorites = false;
          animate-appicon-hover = false;
        };
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.dash-to-panel
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-connections
    gnome-contacts
    gnome-weather
    gnome-maps
    totem
    simple-scan
    snapshot
    gnome-tour
    decibels
    gnome-console
    geary
    epiphany
    gnome-music
    yelp
  ];
}
