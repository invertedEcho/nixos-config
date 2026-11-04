{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    scrcpy
    kdiskmark
    oversteer
    f3d
    gimp3
    blender
    pinta
    vlc
    ldtk
    gnome-disk-utility
  ];
}
