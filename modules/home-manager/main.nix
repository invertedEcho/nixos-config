{
  config,
  pkgs,
  lib,
  hostId,
  ...
}: {
  imports =
    [
      ./dconf.nix
      ./gtk.nix
      ./hypr/hyprland.nix
      ./hypr/hyprlock.nix
      ./git.nix
      ./wezterm.nix
      ./rofi.nix
      ./waybar.nix
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
      "${config.xdg.configHome}/nvim" = {
        source = pkgs.fetchFromGitHub {
          owner = "invertedEcho";
          repo = "nvim-config";
          rev = "e363a643e1533c36fd9148db201514f240758d42";
          hash = "sha256-YQryvm/hi4NeNYhKISuNxlixsWFD1xhC7Xo4SdEM5Q8=";
        };
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
