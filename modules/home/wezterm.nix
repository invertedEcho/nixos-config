{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      return {
      color_scheme = "Gruvbox Dark (Gogh)",
      font = wezterm.font({
      family = "JetBrains Mono Nerd Font Mono",
      -- disable ligatures
      harfbuzz_features = { "calt=0", "clig0", "liga=" },
      }),
      font_size = 13,
      hide_tab_bar_if_only_one_tab = true,
      audible_bell = "Disabled",
      -- I need this keybind in neovim for resizing buffer
      keys = {
      {
      key = "L",
      mods = "CTRL",
      action = wezterm.action.DisableDefaultAssignment,
      },
      },
      }
    '';
  };
}
