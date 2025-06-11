{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/shell" = {
      enabled-extensions = ["paperwm@paperwm.github.com" "appindicatorsupport@rgcjonas.gmail.com"];
    };
    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };
    "org/gnome/shell/extensions/paperwm" = {
      horizontal-margin = 15;
      selection-border-radius-bottom = 10;
      selection-border-radius-top = 10;
      selection-border-size = 5;
      # Top margin
      vertical-margin = 15;
      # Bottom margin
      vertical-margin-bottom = 15;
      window-gap = 10;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      new-window = [""];
      switch-down = [""];
      switch-left = [""];
      switch-right = [""];
      switch-up = [""];
      switch-global-left = ["<Super>h"];
      switch-global-right = ["<Super>l"];
      switch-global-up = ["<Super>k"];
      switch-global-down = ["<Super>j"];
      switch-monitor-left = ["<Shift><Super>h"];
      switch-monitor-right = ["<Shift><Super>l"];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "wezterm";
      name = "Launch wezterm";
    };
  };
}
