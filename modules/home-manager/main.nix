{
  pkgs,
  inputs,
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
      inputs.nixvim-config.packages.${pkgs.system}.default
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "vi";
    };

    file = {
      "Pictures/Wallpapers" = {
        source = ../../assets/wallpapers;
      };
    };
  };

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
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
