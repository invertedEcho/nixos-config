{
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };

    ausweisapp = {
      enable = true;
      openFirewall = true;
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tmux.enable = true;
    command-not-found.enable = false;
    nix-index.enable = true;
  };
}
