{
  pkgs,
  config,
  inputs,
  ...
}: {
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
      package = pkgs.vimix-cursor-theme;
      name = "Vimix-Cursors";
    };

    file = {
      "${config.xdg.configHome}" = {
        source = pkgs.fetchFromGitHub {
          owner = "invertedEcho";
          repo = "dotfiles";
          rev = "7ed48fe4f827";
          hash = "sha256-hsDrmcz8AEC/Xw9Z3pnuQbttxmI1I2G0eWThGdeiZdE=";
        };
        recursive = true;
      };
      "Pictures/Wallpapers" = {
        source = ../../media/wallpapers;
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
        cr = "cargo run";
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
