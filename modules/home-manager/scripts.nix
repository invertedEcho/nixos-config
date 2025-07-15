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
    ".local/bin/audio_safety_notify.sh" = {
      executable = true;
      text = ''
        #!/bin/sh
        # Note, this script is specifically for MOONDROP Kato IEM with Apple USB-C DAC
        # It uses NIOSH (National Institute for Occupational Safety and Health) guidelines

        # Constants
        SENSITIVITY_DB=123   # dB SPL at 0 dB digital volume

        # Get the default sink name
        default_sink=$(pactl info | grep "Default Sink:" | cut -d' ' -f3)

        if [[ -z "$default_sink" ]]; then
        notify-send "Unable to detect default sink"
        exit 1
        fi

        # Get volume of the default sink in dB
        volume_db=$(pactl list sinks | awk -v sink="$default_sink" '
        $0 ~ "Name: "sink { found=1 }
        found && /Volume:/ {
        match($0, /[-+][0-9.]+ dB/, m)
        if (m[0] != "") {
        print m[0]
        exit
        }
        }' | sed 's/ dB//')

        if [[ -z "$volume_db" ]]; then
        notify-send "Unable to detect volume for sink: $default_sink"
        exit 1
        fi

        # Calculate actual SPL
        spl=$(echo "$SENSITIVITY_DB + $volume_db" | bc)
        spl_int=$(printf "%.0f" "$spl")

        # Determine safe listening time
        safe_minutes="Unlimited"
        if (( $(echo "$spl >= 85" | bc -l) )); then
        over_db=$(echo "$spl - 85" | bc)
        divisor=$(echo "scale=10; 2 ^ ($over_db / 3)" | bc -l)
        safe_minutes=$(printf "%.0f" "$(echo "480 / $divisor" | bc)")
        fi

        # Output and notification
        if [[ "$safe_minutes" != "Unlimited" ]]; then
        notify-send -u normal "🎧 Unsafe Volume Alert" \
        "You're listening at ''${spl_int} dB SPL.\nSafe time: ''${safe_minutes} min"
        else
        echo "You're within safe listening levels."
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
  subprocess.run(SPLITTED_MONITOR_CMD + [f'{MONITOR_NAME},preferred,auto,1'])
  subprocess.run(['notify-send', 'Enabled external monitor'])
else:
  subprocess.run(SPLITTED_MONITOR_CMD + [f'{MONITOR_NAME},disable'])
  subprocess.run(['notify-send', 'Disabled external monitor'])
      '';
    };
  };
}
