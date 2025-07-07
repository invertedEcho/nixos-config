{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 50;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["mpris"];
        modules-right = [
          "network"
          "memory"
          "cpu"
          "backlight"
          "battery"
          "pulseaudio"
          "tray"
          "clock#date"
          "clock#time"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1 main";
            "2" = "2 web";
            "3" = "3 misc";
            "4" = "4 notes";
            "5" = "5 chat";
            "6" = "6 music";
            "7" = "7";
            "8" = "8 game";
            "9" = "9 other big apps";
          };
        };

        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "  {icon}  {capacity}%";
          format-discharging = "{icon}  {capacity}%";
          format-icons = ["" "" "" "" ""];
          tooltip = true;
        };

        "clock#time" = {
          interval = 1;
          format = " {:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 10;
          format = "󰃶 {:%e %b}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        cpu = {
          interval = 5;
          format = "  {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        memory = {
          interval = 5;
          format = "  {}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        backlight = {
          format = "{icon} {percent}% ";
          format-icons = ["󰃠"];
        };

        network = {
          interval = 5;
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  {ifname}";
          format-disconnected = "⚠  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          on-click = "iwgtk";
        };

        "hyprland/window" = {
          format = "{}";
          "max-length" = 120;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}% 󰂯";
          format-bluetooth-muted = "󰖁 {icon} 󰂯";
          format-muted = "󰖁 0%";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "󰋋";
            "hands-free" = "󱡒";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        tray = {
          "icon-size" = 21;
          spacing = 10;
        };

        mpris = {
          format = "{player_icon} {title} - {artist}";
          format-paused = "{status_icon} <i>{title} - {artist}";
          "player-icons" = {
            default = "▶";
            spotify = "";
          };
          "status-icons" = {
            paused = "⏸";
          };
        };
      }
    ];
    style = ''
          /* -----------------------------------------------------------------------------
       * Keyframes
       * -------------------------------------------------------------------------- */

      @keyframes blink-warning {
          70% {
              color: #fbf1c7;
          }

          to {
              color: #fbf1c7;
              background-color: #fabd2f;
          }
      }

      @keyframes blink-critical {
          70% {
            color: #fbf1c7;
          }

          to {
              color: #fbf1c7;
              background-color: #fb4934;
          }
      }


      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      * {
          border: none;
          border-radius: 5px;
          min-height: 25px;
          margin: 2px;
          padding: 0;
          font-weight: 500;
      }

      /* The whole bar */
      #waybar {
          background: #282828;
          color: #fbf1c7;
          font-family: JetBrainsMono Nerd Font;
          font-size: 14px;
          border-radius: 0;
      }

      /* Each module */
      #battery,
      #date,
      #clock,
      #cpu,
      #custom-keyboard-layout,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #backlight,
      #tray {
          padding-left: 10px;
          padding-right: 10px;
          background-color: #3c3836;
      }

      /* -----------------------------------------------------------------------------
       * Module styles
       * -------------------------------------------------------------------------- */

      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
          background-color: #b16286;
          color: #1d2021;
      }

      #battery.warning {
          color: #fabd2f;
      }

      #battery.critical {
          color: #fb4934;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #clock {
          font-weight: 500;
          background-color: #fabd2f;
          color: #1d2021;
      }

      #cpu.warning {
          color: #fabd2f;
      }

      #cpu.critical {
          color: #fb4934;
      }

      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #memory.warning {
          color: #fabd2f;
      }

      #memory.critical {
          color: #fb4934;
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #network.disconnected {
          color: #fabd2f;
      }

      #custom-spotify {
          color: #8ec07c;
      }

      #temperature.critical {
          color: #fb4934;
      }

      #workspaces button {
          padding-left: 10px;
          padding-right: 10px;
          color: #fbf1c7;
          background-color: #3c3836;
      }

      #workspaces button.active {
          border-color: #458588;
          color: #1d2021;
          background-color: #fbf1c7;
      }

      #workspaces button.urgent {
          border-color: #9d0006;
          color: #9d0006;
      }

      #pulseaudio {
        background-color: #8ec07c;
        color: #1d2021;
      }
    '';
  };
}
