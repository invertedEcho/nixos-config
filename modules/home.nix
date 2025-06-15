{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./home/dconf.nix
    ./home/xdg.nix
    ./home/gtk.nix
  ];

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
          rev = "737c5bcd3b9e";
          hash = "sha256-rRfB+nJ/847RWpWzJYgVsQ6n5Gfcf6+1wEnCClPuBq8=";
        };
        recursive = true;
      };
      "Pictures/Wallpapers" = {
        source = ../assets/wallpapers;
      };
    };
  };

  programs = {
    home-manager.enable = true;
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
