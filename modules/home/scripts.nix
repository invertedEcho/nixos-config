{
  home.file = {
    ".local/bin/toggle-night-mode.sh" = {
      executable = true;
      text = ''
        #!/bin/sh
        if pgrep -f 'gammastep' >/dev/null
        then
        notify-send "Night Mode off"
        ps aux | grep 'gammastep' | grep -v grep | awk '{print $2}' | xargs kill
        else
        notify-send "Night Mode on"
        gammastep -O 3000
        fi
      '';
    };
    ".local/bin/toggle-bar.sh" = {
      executable = true;
      text = ''
        #!/bin/sh
        if pgrep -f 'waybar' >/dev/null
        then
        notify-send "Killing waybar..."
        ps aux | grep 'waybar' | grep -v grep | awk '{print $2}' | xargs kill
        else
        notify-send "Starting waybar..."
        waybar
        fi
      '';
    };
  };
}
