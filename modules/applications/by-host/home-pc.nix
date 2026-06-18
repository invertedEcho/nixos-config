{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    oversteer
    f3d
    discord
    gimp3
    blender
    pinta
    vlc
    ldtk
    gnome-disk-utility
  ];
}
