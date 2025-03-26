{
  pkgs,
  config,
  ...
}: {
  home = {
    username = "echo";
    homeDirectory = "/home/echo";
    stateVersion = "23.11";

    packages = with pkgs; [pure-prompt zoxide];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "vi";
    };

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.vimix-cursor-theme;
      name = "Vimix-Cursors";
    };

    file = {
      "${config.xdg.configHome}" = {
        source = pkgs.fetchFromGitHub {
          owner = "invertedEcho";
          repo = "dotfiles";
          rev = "c1ab8f86bef41d995acda3311a5519a99698d603";
          hash = "sha256-wxYc5LyLu+d4H4mdBG/zxv9GBd6uLG2inUvpvrjUwyw";
        };
        recursive = true;
      };
      "${config.xdg.configHome}/nvim" = {
        source = pkgs.runCommand "nvim-config" {} ''
          src=${pkgs.fetchFromGitHub {
            owner = "invertedEcho";
            repo = "nvim-config";
            rev = "88f622e70bd0d3cb110cac5996db893bb7214061";
            hash = "sha256-hpJ+BuWUzxcjyRAHJA8vIDEbeSQKHY+lwWa+qckztf0=";
          }}

          mkdir -p $out
          cp -r $src/nvim/* $out/
        '';
        recursive = true;
      };
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
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initExtra = ''
        prompt pure
        eval "$(zoxide init zsh)"
        source <(fzf --zsh)
        bindkey -e
      '';
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
}
