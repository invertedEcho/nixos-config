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
  ];
}
