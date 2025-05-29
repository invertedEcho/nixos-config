{pkgs, ...}: {
  services = {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    dolphin
    ark
    plasma-browser-integration
    konsole
    elisa
    khelpcenter
    kate
    okular
  ];
}
