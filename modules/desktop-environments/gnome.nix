{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs; [
    gnomeExtensions.paperwm
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
