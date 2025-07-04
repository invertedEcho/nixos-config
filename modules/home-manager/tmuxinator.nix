{
  home.file.".tmuxinator/endless-scroller-bevy.yml" = {
    text = ''
      name: endless-scroller-bevy
      root: ~/dev/endless-scroller-bevy

      windows:
       - editor:
         - nvim
       - git:
         - lazygit
       - cargo:
         - cargo run
    '';
  };
}
