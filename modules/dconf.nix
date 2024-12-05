# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "blue";
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = ["light-style@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "drive-menu@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "status-icons@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "system-monitor@gnome-shell-extensions.gcampax.github.com" "dash-to-dock@micxgx.gmail.com"];
      enabled-extensions = ["dash-to-panel@jderose9.github.com"];
      favorite-apps = ["firefox.desktop" "org.gnome.Nautilus.desktop" "kitty.desktop"];
      welcome-dialog-last-shown-version = "47.1";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = true;
      appicon-margin = 8;
      appicon-padding = 4;
      appicon-style = "NORMAL";
      available-monitors = [0];
      click-action = "CYCLE-MIN";
      dot-position = "TOP";
      dot-style-focused = "METRO";
      group-apps = true;
      group-apps-label-font-size = 16;
      group-apps-label-max-width = 90;
      hotkeys-overlay-combo = "TEMPORARILY";
      intellihide = true;
      intellihide-behaviour = "ALL_WINDOWS";
      intellihide-hide-from-windows = true;
      intellihide-use-pressure = false;
      leftbox-padding = -1;
      panel-anchors = ''
        {"0":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"0":100}
      '';
      panel-sizes = ''
        {"0":48}
      '';
      primary-monitor = 0;
      show-tooltip = false;
      show-window-previews = false;
      status-icon-padding = -1;
      stockgs-keep-dash = false;
      stockgs-keep-top-panel = false;
      taskbar-locked = false;
      trans-gradient-bottom-opacity = 0.0;
      trans-panel-opacity = 0.2;
      trans-use-custom-bg = false;
      trans-use-custom-gradient = false;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = false;
      tray-padding = -1;
      window-preview-title-position = "TOP";
    };
  };
}
