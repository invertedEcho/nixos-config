{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/shell" = {
      favorite-apps = ["org.gnome.Calendar.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Settings.desktop" "firefox.desktop" "code.desktop" "kitty.desktop" "obsidian.desktop"];
      enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com" "user-theme@gnome-shell-extensions.gcampax.github.com"];
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Gruvbox-Dark";
    };
    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty";
      name = "Launch kitty";
    };
  };
}
