{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    oversteer
    f3d
    onlyoffice-desktopeditors
    discord
    gimp3
    blender
    unstable.feishin
    pinta
    vlc
    ldtk
    gnome-disk-utility
    spek
  ];
}
