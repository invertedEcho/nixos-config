{pkgs, ...}: {
  services = {
    # I could disable this, but I still need Plasma (X11) for spotify equalizer dropdown to work ):
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
    xsel
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # TODO: Why is dolpin still installed ):
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
