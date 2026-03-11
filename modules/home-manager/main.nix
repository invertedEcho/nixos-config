{
  config,
  pkgs,
  hostId,
  ...
}: {
  imports = [
    ./dconf.nix
    ./gtk.nix
    ./xdg.nix
    ./hypr.nix
  ];
  # ++ lib.optionals (hostId
  #   == "thinkpad") [./hypr/hypridle.nix];

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
  };

  programs = {
    home-manager.enable = true;
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
        update = "cd ~/dev/nixos-config && sudo nixos-rebuild switch --flake .#${hostId} && cd -";
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
