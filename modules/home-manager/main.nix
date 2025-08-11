{
  config,
  pkgs,
  lib,
  hostId,
  dotfiles,
  nvim-config,
  ...
}: {
  imports =
    [
      ./dconf.nix
      ./gtk.nix
      ./scripts.nix
      ./tmux.nix
      ./tmuxinator.nix
    ]
    ++ lib.optionals (hostId
      == "thinkpad") [./hypr/hypridle.nix];

  home = {
    username = "echo";
    homeDirectory = "/home/echo";
    stateVersion = "23.11";

    packages = with pkgs; [
      pure-prompt
      zoxide
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "vi";
    };

    file = {
      "Pictures/Wallpapers" = {
        source = ../../assets/wallpapers;
      };
      # I really dont care that this will cause impurity
      "${config.xdg.configHome}/nvim" = {
        source = nvim-config;
      };
      "${config.xdg.configHome}" = {
        source = dotfiles;
        recursive = true;
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
        ga = "git add .";
        gp = "git pull";
        gP = "git push";
        cr = "cargo run";
        update = "cd ~/dev/nixos-config && sudo nixos-rebuild switch --flake .#${hostId} --impure && cd -";
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
