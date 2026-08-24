{
  services.xserver.desktopManager.cinnamon.enable = true;
  # NOTE: gdm doesnt seem to work with cinnamon, but ly does.
  services.displayManager.ly.enable = true;
  services.xserver.enable = true;
}
