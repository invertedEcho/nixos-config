{pkgs, ...}: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };
  environment.systemPackages = with pkgs; [kdePackages.bluedevil];
}
