{pkgs, ...}: {
  programs = {
    tmux = {
      enable = true;
      extraConfig = ''
        set -as terminal-features ",xterm-256color:RGB"
      '';
      # Sorry father for what i have sinned
      mouse = true;
      plugins = with pkgs; [
        tmuxPlugins.gruvbox
      ];
    };
    zsh = {
      initContent = ''
        if [[ ! $(tmux list-sessions) ]]; then
        tmux
        fi
      '';
    };
  };
}
