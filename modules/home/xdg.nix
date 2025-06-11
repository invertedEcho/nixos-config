{pkgs, ...}: {
  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs.spotify}/share/applications/spotify.desktop"
      "${pkgs._1password-gui}/share/applications/1password.desktop"
    ];
  };
}
