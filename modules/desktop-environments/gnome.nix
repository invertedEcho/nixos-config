{
  pkgs,
  lib,
  ...
}: {
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xserver = {
      enable = true;
    };
    udev.packages = with pkgs; [gnome-settings-daemon];
  };

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [""];
        };
        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Super>q"];
          minimize = ["@as []"];
          # move window to monitor
          move-to-monitor-left = ["<Shift><Super>h"];
          move-to-monitor-right = ["<Shift><Super>l"];
          switch-to-application-1 = ["@as []"];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          # very weird, this is keybind for lockscreen, which i unset because i need Super + L for focus changer extension
          screensaver = ["@as []"];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>d";
          command = "vicinae open";
          name = "Open vicinae";
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = ["compose:caps"];
        };
        "org/gnome/desktop/peripherals/mouse" = {
          "accel-profile" = ["flat"];
        };
        "org/gnome/shell" = {
          enabled-extensions = [
            "display-brightness-ddcutil@themightydeity.github.com"
            "appindicatorsupport@rgcjonas.gmail.com"
            "focus-changer@heartmire"
            # "dash-to-dock@micxgx.gmail.com"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "blur-my-shell@aunetx"
            "current-monitor-window-app-switcher@thmatosbr"
            "rounded-window-corners@fxgn"
          ];
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/shell/extensions/user-theme" = {
          name = "Marble-blue-dark";
        };
        # "org/gnome/shell/extensions/dash-to-dock" = {
        #   dash-max-icon-size = lib.gvariant.mkInt32 48;
        #   # Shrink the dock
        #   custom-theme-shrink = true;
        #   # Dont launch applications with Super+[0-9], need that for switching workspaces.
        #   hot-keys = false;
        # };
        "org/gnome/shell/extensions/dash-to-panel" = {
          group-apps = false;
          intellihide = true;
          trans-use-border = true;
          trans-border-width = lib.gvariant.mkInt32 1;
          trans-panel-opacity = 0.3;
          show-favorites = false;
          animate-appicon-hover = false;
          group-apps-label-max-width = lib.gvariant.mkInt32 0;
        };
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator
    gnomeExtensions.brightness-control-using-ddcutil
    # gnomeExtensions.dash-to-dock
    gnomeExtensions.focus-changer
    gnome-tweaks
    marble-shell-theme
  ];

  nixpkgs.overlays = [
    (final: prev: {
      marble-shell-theme = prev.marble-shell-theme.override {
        # https://github.com/imarkoff/Marble-shell-theme#-installation-tweaks
        additionalInstallationTweaks = ["--filled" "--launchpad"];
      };
    })
  ];

  environment.gnome.excludePackages = with pkgs; [
    seahorse
    gnome-connections
    gnome-contacts
    gnome-weather
    gnome-maps
    totem
    simple-scan
    snapshot
    gnome-tour
    decibels
    gnome-console
    geary
    epiphany
    gnome-music
    yelp
  ];

  systemd.services.applyUserMonitorSettings = let
    username = "echo";
    gdmConfigDir = "/etc/xdg/";
    monitorFile = "/home/${username}/.config/monitors.xml";
    script = pkgs.writeShellScript "apply-monitor-settings" ''
      echo "Applying user monitor settings to GDM login screen"

      if [ ! -f "${monitorFile}" ]; then
        echo "No monitors.xml found, skipping"
        exit 0
      fi

      mkdir -p "${gdmConfigDir}"

      if [ ! "${monitorFile}" -ef "${gdmConfigDir}/monitors.xml" ]; then
        cp "${monitorFile}" "${gdmConfigDir}/monitors.xml"
        chown gdm:gdm "${gdmConfigDir}/monitors.xml"
        echo "Copied monitors.xml to GDM config"
      else
        echo "monitors.xml already up to date"
      fi
    '';
  in {
    description = "Apply user monitor settings to GDM login screen";
    after = [
      "network.target"
      "systemd-user-sessions.service"
      "display-manager.service"
    ];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = script;
    };
  };
}
