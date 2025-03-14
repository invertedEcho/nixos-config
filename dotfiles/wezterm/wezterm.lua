local wezterm = require("wezterm")
local utils = require("utils")

return {
	color_scheme = "Gruvbox Dark (Gogh)",
	font = wezterm.font("Terminess Nerd Font Mono"),
	font_size = utils.is_linux() and 12 or 18,
	front_end = "WebGpu",
	hide_tab_bar_if_only_one_tab = true,
	enable_wayland = false,
}
