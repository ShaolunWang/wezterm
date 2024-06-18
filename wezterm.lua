-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
--local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'SeaShells'

local config = {
	audible_bell = 'Disabled',
	check_for_updates = false,
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	launch_menu = {},
	leader = { key = ';', mods = 'CTRL' },
	disable_default_key_bindings = true,
	keys = require('key'),
	set_environment_variables = {},
	default_prog = { 'pwsh', '-NoLogo' },
--	default_prog = { 'elvish'},
}
require('theme').apply(config)
return config
