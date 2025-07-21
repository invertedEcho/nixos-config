{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.gruvbox-gtk-theme.override {
        colorVariants = ["dark"];
        iconVariants = ["Dark"];
      };
      name = "Gruvbox-Dark";
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
