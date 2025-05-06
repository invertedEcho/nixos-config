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
          rev = "9932f9af3015";
          hash = "sha256-t2oVIlvfRBOMCkwlMxaF6ep0rYvLVwvw08vTFDnCnCI=";
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
