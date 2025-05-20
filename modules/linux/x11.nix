{pkgs, ...}: {
  services.xserver = {
    enable = true;
    dpi =
      if pkgs.system == "aarch64-linux"
      then 220
      else null;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    windowManager.i3 = {
      enable = true;
    };
    displayManager.startx.enable = true;
  };
}
