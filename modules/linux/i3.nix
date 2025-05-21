{pkgs, ...}: {
  services.xserver = {
    enable = true;
    dpi =
      if pkgs.system == "aarch64-linux"
      then 220
      else null;
    windowManager.i3 = {
      enable = true;
    };
  };
}
