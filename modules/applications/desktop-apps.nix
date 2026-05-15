{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    oversteer
    f3d
    jellyfin-media-player
    onlyoffice-desktopeditors
    discord
    gimp3
    blender
    unstable.feishin
    pinta
    vlc
    ldtk
    gnome-disk-utility
    obs-studio
    spek
  ];
}
