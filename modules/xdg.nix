{pkgs, ...}: {
  xdg = {
    autostart = {
      enable = true;
      entries = [
        "${pkgs.protonvpn-gui}/share/applications/proton.vpn.app.gtk.desktop"
        "${pkgs.feishin}/share/applications/feishin.desktop"
        "${pkgs.obsidian}/share/applications/obsidian.desktop"
      ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "image/png" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "application/json" = "org.gnome.gedit.desktop";
      };
    };
  };
}
