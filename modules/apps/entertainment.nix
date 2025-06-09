{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [
    spotify
    jellyfin-media-player
    vlc
  ];
}
