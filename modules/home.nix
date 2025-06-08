{
  pkgs,
  config,
  inputs,
  ...
}: {
  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs.spotify}/share/applications/spotify.desktop"
      "${pkgs._1password-gui}/share/applications/1password.desktop"
      "${pkgs.activitywatch}/share/applications/aw-qt.desktop"
    ];
    # Can't set this to true because of plasma-manager
    readOnly = false;
  };

  # TODO: I want this in a seperate home file
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home = {
    username = "echo";
    homeDirectory = "/home/echo";
    stateVersion = "23.11";

    packages = with pkgs; [
      pure-prompt
      zoxide
      inputs.nixvim-config.packages.${pkgs.system}.default
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "vi";
    };

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.vimix-cursors;
      name = "Vimix-Cursors";
    };

    file = {
      "${config.xdg.configHome}" = {
        source = pkgs.fetchFromGitHub {
          owner = "invertedEcho";
          repo = "dotfiles";
          rev = "3b2f290030de";
          hash = "sha256-lJx8VBr3+eDWYrgyVG+i+CZuYnKgvEZLARidsV+k5MY=";
        };
        recursive = true;
      };
      "Pictures/Wallpapers" = {
        source = ../assets/wallpapers;
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };

    font = {
      name = "Sans";
      size = 11;
    };
    # workaround https://github.com/nix-community/plasma-manager/issues/472
    # This errors
    # home.file.".gtkrc-2.0".force = true;
    gtk2.configLocation = "${config.home.homeDirectory}/.config/.gtkrc-2.0";
  };

  programs = {
    home-manager.enable = true;
    wezterm = {
      enable = true;
      extraConfig = ''
      '';
    };
    git = {
      enable = true;
      userName = "Jakob Stechow";
      userEmail = "jakob.stechow@pm.me";
    };
    zsh = {
      enable = true;
      shellAliases = {
        n = "nvim";
        lg = "lazygit";
        rm = "trash";
        ".." = "cd ..";
        gp = "git pull";
        gP = "git push";
        cr = "cargo run";
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        prompt pure
        eval "$(zoxide init zsh)"
        source <(fzf --zsh)
        bindkey -e
      '';
    };
    # TODO: I want this in a seperate home file
    plasma = {
      enable = true;
      workspace = {
        # Layan as global theme
        lookAndFeel = "com.github.vinceliuice.Layan";
        # Forest path wallpaper
        wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Path/contents/images/1920x1080.jpg";
      };
      panels = [
        {
          location = "bottom";
          widgets = [
            {
              kickoff = {
                icon = "nix-snowflake-white";
              };
            }
            {
              iconTasks = {
                launchers = [
                  "applications:kdesystemsettings.desktop"
                  "applications:firefox.desktop"
                  "applications:org.gnome.Nautilus.desktop"
                  "applications:org.wezfurlong.wezterm.desktop"
                  "applications:discord.desktop"
                  "applications:steam.desktop"
                  "applications:spotify.desktop"
                  "applications:1password.desktop"
                ];
              };
            }
            {
              panelSpacer = {
                expanding = true;
              };
            }
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
                # We explicitly show bluetooth and battery
                # shown = [
                #   "org.kde.plasma.battery"
                #   "org.kde.plasma.bluetooth"
                # ];
                # And explicitly hide networkmanagement and volume
                # hidden = [
                #   "org.kde.plasma.networkmanagement"
                #   "org.kde.plasma.volume"
                # ];
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
              };
            }
          ];
        }
      ];
      shortcuts = {
        "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
        "kwin"."Suspend Compositing" = ["Alt+Shift+F10"];
        "kwin"."Window Maximize" = ["Meta+M"];
        "kwin"."Window Minimize" = ["Meta+H"];
        "services/org.wezfurlong.wezterm.desktop"."_launch" = "Meta+Return";
      };
    };
  };
}
