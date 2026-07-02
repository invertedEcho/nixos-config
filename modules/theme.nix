{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bibata-cursors
    colloid-gtk-theme
    colloid-icon-theme
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
        };
      };
    }
  ];
}
