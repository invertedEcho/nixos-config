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
        gammastep -O 3500
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
    ".local/bin/print-keyboard-layout.sh" = {
      executable = true;
      text = ''
        #!/run/current-system/sw/bin/bash
        OUTPUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

        if [[ "$OUTPUT" == "English (US)" ]]; then
            echo "us"
        elif [[ "$OUTPUT" == "German" ]]; then
            echo "de"
        else
            echo "$OUTPUT"
        fi
      '';
    };
    ".local/bin/toggle-external-monitor.py" = {
      text = ''
        #!/run/current-system/sw/bin/python3

        import subprocess
        import json

        MONITOR_NAME = "HDMI-A-1"
        SPLITTED_MONITOR_CMD = 'hyprctl keyword monitor'.split(" ")

        all_monitors_output_subprocess = subprocess.run(['hyprctl', 'monitors', 'all', '-j'], capture_output=True,text=True)
        all_monitors_output_json = json.loads(all_monitors_output_subprocess.stdout)
        filtered_monitor = next(filter(lambda monitor : monitor['name'] == MONITOR_NAME, all_monitors_output_json))

        is_external_monitor_disabled = filtered_monitor['disabled'] is True

        if is_external_monitor_disabled:
          subprocess.run(SPLITTED_MONITOR_CMD + [f'{MONITOR_NAME},preferred,auto,2'])
          subprocess.run(['notify-send', 'Enabled external monitor'])
        else:
          subprocess.run(SPLITTED_MONITOR_CMD + [f'{MONITOR_NAME},disable'])
          subprocess.run(['notify-send', 'Disabled external monitor'])
      '';
    };
  };
}
