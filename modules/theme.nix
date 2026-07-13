{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bibata-cursors
    colloid-icon-theme
    volantes-cursors
    orchis-theme
  ];

  programs.dconf.profiles.user.databases = [
    {
      lockAll = false;
      settings = {
        "org/gnome/desktop/interface" = {
          "cursor-size" = lib.gvariant.mkInt16 32;
          # The cursor theme name is the directory name of the cursor theme.
          # They are most likely located at /run/current-system/sw/share/icons/
          "cursor-theme" = "Bibata-Modern-Ice";
          "gtk-theme" = "Orchis-Dark";
        };
      };
    }
  ];
}
