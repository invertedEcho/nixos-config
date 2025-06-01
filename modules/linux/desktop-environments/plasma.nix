{pkgs, ...}: {
  services = {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "sugar-dark";
      package = pkgs.lib.mkForce pkgs.libsForQt5.sddm;
      extraPackages = pkgs.lib.mkForce [pkgs.libsForQt5.qt5.qtgraphicaleffects];
    };
    desktopManager.plasma6.enable = true;
  };

  environment.defaultPackages = with pkgs; [
    sddm-sugar-dark
  ];

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
