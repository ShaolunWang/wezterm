-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
--local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'SeaShells'

local config = {
	window_decorations = 'INTEGRATED_BUTTONS | RESIZE',
	integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },
	tab_bar_style = {
		window_hide = window_min,
		window_hide_hover = window_min,
		window_maximize = window_max,
		window_maximize_hover = window_max,
		window_close = window_close,
		window_close_hover = window_close,
	},
	audible_bell = 'Disabled',
	check_for_updates = false,
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	font_size = 12,
	font = wezterm.font('BlexMono Nerd Font Mono'),
	--	color_scheme = 'tokyonight_night',
	color_scheme = 'Monokai Pro Ristretto (Gogh)',
	launch_menu = {},
	leader = { key = ';', mods = 'CTRL' },
	disable_default_key_bindings = true,
	keys = require('key'),
	set_environment_variables = {},
	default_prog = { 'pwsh', '-NoLogo' },
	--	default_prog = { 'elvish'},
}
require('theme').apply_to_config(config, { enabled_modules = { username = false, hostname = false } })

return config
