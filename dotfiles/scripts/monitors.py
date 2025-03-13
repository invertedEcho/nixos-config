#!/run/current-system/sw/bin/python3
import subprocess
import json
import sys


SPLITTED_MONITOR_CMD = 'hyprctl keyword monitor'.split(" ")
SPLITTED_MOVE_WORKSPACE_CMD = 'hyprctl dispatch moveworkspacetomonitor'.split(" ")

LAPTOP_MONITOR_NAME = 'eDP-1'
TV_MONITOR_NAME = 'HDMI-A-1'
TV_MONITOR_DESC = 'XXX Beyond TV 0x00010000'


def send_message(msg: str):
    subprocess.run(['notify-send', msg])


def get_all_monitors_output():
    all_monitors_subprocess = subprocess.run(['hyprctl', 'monitors', 'all', '-j'],
                                             capture_output=True,
                                             text=True)

    if all_monitors_subprocess.returncode != 0:
        subprocess.run(['notify-send',
                        'Failed to run hyprctl to get all monitors.'])

    return json.loads(all_monitors_subprocess.stdout)


def get_is_laptop(all_monitors_output):
    return any(monitor['name'] == 'eDP-1' for monitor in all_monitors_output)


def setup_monitors(is_laptop: bool):
    if is_laptop:
        subprocess.run(SPLITTED_MONITOR_CMD + ['desc:GIGA-BYTE TECHNOLOGY CO. LTD. G27Q 23082B003536, 2560x1440,2560x0,1'])
        subprocess.run(SPLITTED_MONITOR_CMD + ['desc:GIGA-BYTE TECHNOLOGY CO. LTD. G27Q 23082B003522, 2560x1440,0x0,1'])
        subprocess.run(SPLITTED_MONITOR_CMD + ['eDP-1,preferred,auto,1'])

        subprocess.run(SPLITTED_MOVE_WORKSPACE_CMD + ['1', 'desc:GIGA-BYTE TECHNOLOGY CO. LTD. G27Q 23082B003522'])
        subprocess.run(SPLITTED_MOVE_WORKSPACE_CMD + ['2', 'desc:GIGA-BYTE TECHNOLOGY CO. LTD. G27Q 23082B003536'])

        send_message('Successfully setup monitors for Office.')
    else:
        subprocess.run(SPLITTED_MONITOR_CMD + ['desc:Dell Inc. DELL U2415 7MT0177A2T2S,highres,0x0,1'])
        subprocess.run(SPLITTED_MONITOR_CMD + ['desc:Acer Technologies Acer KG271 C 0x9231F806,1920x1080@144,1920x0,1'])

        subprocess.run(SPLITTED_MONITOR_CMD + [f'desc:{TV_MONITOR_DESC},disable'])
        # https://github.com/hyprwm/Hyprland/issues/6032
        subprocess.run(SPLITTED_MONITOR_CMD + ['Unknown-1,disable'])

        subprocess.run(SPLITTED_MOVE_WORKSPACE_CMD + ['2', 'desc:Dell Inc. DELL U2415 7MT0177A2T2S'])
        subprocess.run(SPLITTED_MOVE_WORKSPACE_CMD + ['1',  'desc:Acer Technologies Acer KG271 C 0x9231F806'])

        send_message('Successfully setup monitors for Home.')


def toggle_third_monitor(all_monitors_output, is_laptop: bool):
    monitor_name = LAPTOP_MONITOR_NAME if is_laptop else TV_MONITOR_NAME

    filtered_monitor = next(filter(lambda monitor : monitor['name'] == monitor_name, all_monitors_output))

    is_third_monitor_disabled = filtered_monitor['disabled'] is True

    if is_third_monitor_disabled:
        subprocess.run(SPLITTED_MONITOR_CMD + [f'{monitor_name},preferred,auto,1'])
        send_message(f"Enabled {monitor_name}")
    else:
        subprocess.run(SPLITTED_MONITOR_CMD + [f'{monitor_name},disable'])
        send_message(f"Disabled {monitor_name}")



def main():
    all_monitors_output = get_all_monitors_output()
    is_laptop = get_is_laptop(all_monitors_output=all_monitors_output)

    if len(sys.argv) == 1:
        raise Exception("No 'setup_arg' provided.")

    setup_arg = sys.argv[1]

    match setup_arg:
        case 'setup':
            setup_monitors(is_laptop=is_laptop)
        case 'toggle_third_monitor':
            toggle_third_monitor(all_monitors_output=all_monitors_output, is_laptop=is_laptop)
        case _:
            raise Exception("'setup_arg' must either be 'setup' or 'toggle_third_monitor'.")


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(e)
        send_message(str(e))
