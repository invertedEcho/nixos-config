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
      lockAll = false;
      settings = {
        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Super>q"];
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = ["compose:caps"];
        };
        "org/gnome/shell" = {
          enabled-extensions = ["display-brightness-ddcutil@themightydeity.github.com" "appindicatorsupport@rgcjonas.gmail.com" "dash-to-dock@micxgx.gmail.com"];
        };
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
    gnomeExtensions.appindicator
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.dash-to-dock
  ];

  environment.gnome.excludePackages = with pkgs; [
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
    gdmConfigDir = "/var/lib/gdm/seat0/config";
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
