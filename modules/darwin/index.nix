{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.shellAliases = {
    n = "nvim";
    lg = "lazygit";
    rm = "trash";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  security.pam.enableSudoTouchIdAuth = true;

  programs = {
    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;

      promptInit = ''
        autoload -U promptinit && promptinit && prompt pure
        eval "$(zoxide init zsh)"
        source <(fzf --zsh)
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh
      '';
    };
  };

  system = {
    stateVersion = 5;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv"; # default list view
        _FXShowPosixPathInTitle = true;
      };
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
