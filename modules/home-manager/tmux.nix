{pkgs, ...}: {
  programs = {
    tmux = {
      enable = true;
      extraConfig = ''
        set -as terminal-features ",xterm-256color:RGB"
        set-option -sg escape-time 10
        set-option -g default-terminal "screen-256color"
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
