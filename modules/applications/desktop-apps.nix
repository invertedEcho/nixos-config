{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    ausweisapp
    oversteer
    f3d
    jellyfin-media-player
    onlyoffice-desktopeditors
    discord
    gimp3
    blender
    unstable.feishin
    pinta
    obsidian
    vlc
    ldtk
    gnome-disk-utility
    obs-studio
    spek
  ];
}
