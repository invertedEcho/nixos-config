{
  services.xserver.desktopManager.cinnamon.enable = true;
  # NOTE: gdm doesnt seem to work with cinnamon
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.enable = true;
}
