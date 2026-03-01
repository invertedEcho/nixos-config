{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    # Big desktop apps
    jellyfin-media-player
    jetbrains.pycharm-community-bin
    onlyoffice-bin
    vscode-fhs
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
