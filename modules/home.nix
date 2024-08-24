{ config, pkgs, ... }:

{
  home = {
    username = "echo";
    homeDirectory = "/home/echo";
    stateVersion = "23.11";

    packages = with pkgs; [ pure-prompt zoxide ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "vi";
    };

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      n = "nvim";
      lg = "lazygit";
      ".." = "cd ..";
    };
    initExtra = 
      "autoload -U promptinit; promptinit
prompt pure
eval \"$(zoxide init zsh)\"
source <(fzf --zsh)
bindkey '^[^?' backward-kill-word";
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
    git = {
      enable = true;
      userName = "Jakob Stechow";
      userEmail = "jakob.stechow@pm.me";
      signing = {
        key = null;
        signByDefault = true;
      };
    };

    home-manager.enable = true;
  };
}
