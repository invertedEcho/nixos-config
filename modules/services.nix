{ pkgs, ... }:

{
  services = {
    openssh.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    usbmuxd.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm = {
	enable = true;
	wayland = true;
      };
    };

    udev.packages = [ pkgs.android-udev-rules ];
  };
}
