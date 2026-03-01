{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    # Big desktop apps
    jellyfin-media-player
    onlyoffice-desktopeditors
    discord
    gimp3
    blender
    feishin
    pinta
    obsidian
    vlc
    ldtk
    gnome-disk-utility
  ];
}
