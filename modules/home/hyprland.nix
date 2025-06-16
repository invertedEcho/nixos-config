{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        layout = "dwindle";
        border_size = 2;
      };
      monitor = [
        ",preferred,auto,1"
        "eDP-1,preferred,auto-left,1"
      ];
      "$mod" = "SUPER";
      "$modWithShift" = "SUPER_SHIFT";
      "$modWithAlt" = "SUPER_ALT";
      bind =
        [
          # Window control keybindings
          "$mod, Q, killactive"
          "$modWithShift, Q, exit"
          "$modWithShift, Space, togglefloating"
          "$mod, M, fullscreen, 1"
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          "$modWithShift, F, fullscreen"
          "$modWithShift,h,movewindow,l"
          "$modWithShift,l,movewindow,r"
          "$modWithShift,j,movewindow,d"
          "$modWithShift,k,movewindow,u"

          # Application and script keybindings
          "$mod, F, exec, firefox"
          "$mod, Return, exec, wezterm"
          "$mod, D, exec, ~/.config/rofi/launchers/type-6/launcher.sh"
          "$mod, P, exec, wlogout"
          "$mod, N, exec, notesnook"
          "$modWithAlt, L, exec, hyprlock"
          # TODO: Two below lines should be one script accepting arguments
          # "$mod, S, exec, grim -g '$(slurp)' - | wl-copy && notify-send 'Copied selected region to clipboard.'"
          # bind = $mainModWithShift, S, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/screenshot-$(date +'%Y%m%d-%H%M%S').png && notify-send "Saved selected region to ~/Pictures/Screenshots"
          "$mod, B, exec, ~/.local/bin/toggle-bar.sh"
          "$modWithShift, N, exec, ~/.local/bin/toggle-night-mode.sh"
          "$modWithAlt, N, exec, swaync-client -t"
          "$modWithShift, C, exec, wl-color-picker"
          # TODO: Think about this once migrated away from monitors setup script
          "$modWithShift, T, exec, python3 ~/.config/scripts/monitors.py toggle_third_monitor"

          # Multimedia keybindings
          " , 122, exec, pamixer -d 2"
          " , 123, exec, pamixer -i 2"
          " , 121, exec, pamixer --toggle-mute"
          " , 173, exec, playerctl previous"
          " , 171, exec, playerctl next"
          " , 172, exec, playerctl play-pause"
          " , 232, exec, brightnessctl set 10%-"
          " , 233, exec, brightnessctl set 10%+"

          # Scratchpad -> TODO: What is this code:20 key?
          "$modWithShift,code:20,movetoworkspace,special"
          "$mod,code:20,togglespecialworkspace"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$modWithshift, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrule = [
        "float, class:^(org.gnome.Nautilus)$"
        # iwgtk application itself
        "float, class:^(org.twosheds.iwgtk)$"
        # iwgtk wifi password prompt
        "float, class:^(iwgtk)$"
        "size 60%, class:^(org.gnome.Nautilus)"
        "workspace 6, class:^(spotify)$"
      ];
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "_JAVA_AWT_WM_NONPARENTING,1"
      ];
      # TODO: Remove monitors script, should have monitor setup by host.
      exec-once = [
        "python3 ~/.config/scripts/monitors.py setup"
        "~/.config/scripts/toggle-bar.sh"
        "swaybg -i ~/Pictures/Wallpapers/gruvbox-girl.png -m fill"
        "swaync"
        # TODO: Still needed?
        "gnome-keyring-daemon"
        "systemctl --user start hyprland-session.target"
        # TODO: still needed? initially needed to make firefox screensharing work
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # TODO: Still needed?
        "polkit-agent-helper-1"
        "systemctl start --user polkit-gnome-authentication-agent-1"
      ];
      input = {
        kb_layout = "us,de";
        kb_options = "ctrl:nocaps";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_invert = false;
        workspace_swipe_forever = true;
      };
      decoration = {
        rounding = 5;
        blur.enabled = false;
      };
      misc = {
        disable_hyprland_logo = true;
        vfr = true;
        animate_manual_resizes = true;
      };
      animations = {
        enabled = true;
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,overshot,slide"
          "border,1,10,default"
          "fade,1,10,default"
        ];
      };
    };
    extraConfig = ''
      # Resizing windows submap
      bind = ALT,R,submap,resize
      submap=resize
      binde = ,l,resizeactive,40 0
      binde = ,h,resizeactive,-40 0
      binde = ,k,resizeactive,0 -40
      binde = ,j,resizeactive,0 40
      bind = ,escape,submap,reset
      submap = reset
    '';
  };
}
