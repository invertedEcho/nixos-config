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
          rev = "b60b45397e5f";
          hash = "sha256-VIoohKBjRVNEt33vX3MwsA0M8qsVYtWU6pEUX4SRKek=";
        };
        recursive = true;
      };
      "Pictures/Wallpapers" = {
        source = ../../media/wallpapers;
      };
      "${config.xdg.configHome}/nvim" = {
        source = pkgs.runCommand "nvim-config" {} ''
          src=${pkgs.fetchFromGitHub {
            owner = "invertedEcho";
            repo = "nvim-config";
            rev = "727de4797e82";
            hash = "sha256-+RB2/ATxIXogK/5HqL6warxspDpAErxX+r8syWeBabI=";
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
        gp = "git pull";
        gP = "git push";
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
