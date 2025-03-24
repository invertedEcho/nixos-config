{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.shellAliases = {
    n = "nvim";
    lg = "lazygit";
    rm = "trash";
    ".." = "cd ..";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  security.pam.enableSudoTouchIdAuth = true;

  # TODO: switch to jetbrains nerd font again
  fonts.packages = with pkgs; [terminus-nerdfont];

  programs = {
    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableFzfHistory = true;
      enableFzfCompletion = true;

      promptInit = ''
        autoload -U promptinit && promptinit && prompt pure
        eval "$(zoxide init zsh)"
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        export PATH=$PATH:/opt/homebrew/bin/
        export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
        export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
      '';
    };

    # direnv = {
    #   enable = true;
    #   nix-direnv.enable = true;
    # };
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
        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
      };
      screencapture.type = "jpg";
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
}
