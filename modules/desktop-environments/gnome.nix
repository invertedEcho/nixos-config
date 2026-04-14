{pkgs, ...}: {
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xserver = {
      enable = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
  };
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.launch-new-instance
    gnomeExtensions.blur-my-shell
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.dash-to-panel
  ];
  environment.gnome.excludePackages = with pkgs; [
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
