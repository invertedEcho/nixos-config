{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = ["dark"];
        iconVariants = ["Dark"];
        tweakVariants = ["storm"];
      };
      name = "Tokyonight-Dark-Storm";
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
