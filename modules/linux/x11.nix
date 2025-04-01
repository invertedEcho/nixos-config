{...}: {
  services.xserver = {
    enable = true;
    dpi = 220;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
    };
  };
}
