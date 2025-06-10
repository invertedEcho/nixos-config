{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
  };
  environment.systemPackages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.appindicator
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
  ];
}
