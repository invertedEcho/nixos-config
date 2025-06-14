{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };

    cursorTheme = {
      name = "volantes_cursors";
      package = pkgs.volantes-cursors;
      size = 30;
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
