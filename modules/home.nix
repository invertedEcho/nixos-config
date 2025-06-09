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
  };

  # TODO: I want this in a seperate home file
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };
    "org/gnome/shell/extensions/paperwm" = {
      horizontal-margin = 15;
      selection-border-radius-bottom = 10;
      selection-border-radius-top = 10;
      selection-border-size = 5;
      # Top margin
      vertical-margin = 15;
      # Bottom margin
      vertical-margin-bottom = 15;
      window-gap = 10;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      new-window = [""];
      switch-down = [""];
      switch-left = [""];
      switch-right = [""];
      switch-up = [""];
      switch-global-left = ["<Super>h"];
      switch-global-right = ["<Super>l"];
      switch-global-up = ["<Super>k"];
      switch-global-down = ["<Super>j"];
      switch-monitor-left = ["<Shift><Super>h"];
      switch-monitor-right = ["<Shift><Super>l"];
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

    file = {
      "${config.xdg.configHome}" = {
        source = pkgs.fetchFromGitHub {
          owner = "invertedEcho";
          repo = "dotfiles";
          rev = "f37749a0daaa";
          hash = "sha256-xxXjkZbgZqtXIYzqWGYYVX+XhSNadH2fhO6fyIhsyc8=";
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
  };
}
