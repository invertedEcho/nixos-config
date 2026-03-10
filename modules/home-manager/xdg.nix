{pkgs, ...}: {
  xdg = {
    autostart = {
      enable = true;
      entries = [
        # "${pkgs.spotify}/share/applications/spotify.desktop"
        # "${pkgs._1password-gui}/share/applications/1password.desktop"
      ];
    };
    # https://wiki.nixos.org/wiki/Default_applications
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
      };
    };
  };
}
