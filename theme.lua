local wezterm = require('wezterm')

local M = {}

wezterm.on('update-right-status', function(window, pane)
	local cols = pane:get_dimensions().cols
	local user_vars = pane:get_user_vars()

	local icon = user_vars.tab_icon
	if not icon or icon == '' then
		-- fallback for the icon,
		icon = ''
	end

	local icon_color = user_vars.tab_color
	if not icon_color then
		icon_color = 'white'
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = '#333333' } },
		{ Foreground = { Color = icon_color } },
		{ Text = ' ' .. wezterm.pad_right(icon, 3) },
	}))

	local title = pane:get_title()
	local date = ' ' .. wezterm.strftime('%H:%M %d-%m-%Y') .. ' '

	-- generate padding to center title by adding half of width (cols), half
	-- of title length, length of date string and integrated buttons width
	--
	-- the 1 at the end is cause of extra space after date to separate it from
	-- buttons
	--
	-- if there are any theming in date or title use `wezterm.column.width`
	local padding = wezterm.pad_right('', (cols / 2) - (string.len(title) / 2) - string.len(date) - 3 * 3 - 1)

	window:set_right_status(wezterm.format({
		{ Text = ' ' .. title .. ' ' },
		{ Background = { Color = '#333333' } },
		{ Text = padding },
		{ Background = { Color = '#444444' } },
		{ Text = date },
		{ Background = { Color = '#333333' } },
		{ Text = ' ' },
	}))
end)

wezterm.on('format-tab-title', function(tab, _, _, _, _)
	-- i could forget i've zoomed in and forget about a pane in a tab
	local is_zoomed = ''
	if tab.active_pane.is_zoomed then
		is_zoomed = 'z'
	end

	return {
		{ Text = tab.active_pane .. tab.tab_index + 1 .. is_zoomed .. ' ' },
	}
end)

function M.apply(config)
	--	config.color_scheme = 'TokyoNight'
	--	config.color_scheme = 'Sea Shells'
	config.font_size = 12
	--config.color_scheme = 'Sea Shells (Gogh)'
	--config.color_scheme = 'Ocean Dark (Gogh)'
	-- config.color_scheme = 'Tender (Gogh)'
	config.color_scheme = 'Tokyo Night'

	config.font = wezterm.font('BlexMono Nerd Font Mono')

	config.window_padding = {
		left = '6px',
		right = '6px',
		top = '2px',
		bottom = 0,
	}
	config.colors = {
		tab_bar = {
			-- The color of the strip that goes along the top of the window
			-- (does not apply when fancy tab bar is in use)
			background = '#0b0022',

			-- The active tab is the one that has focus in the window
			active_tab = {
				-- The color of the background area for the tab
				bg_color = '#2b2042',
				-- The color of the text for the tab
				fg_color = '#c0c0c0',

				-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
				-- label shown for this tab.
				-- The default is "Normal"
				intensity = 'Normal',

				-- Specify whether you want "None", "Single" or "Double" underline for
				-- label shown for this tab.
				-- The default is "None"
				underline = 'None',

				-- Specify whether you want the text to be italic (true) or not (false)
				-- for this tab.  The default is false.
				italic = false,

				-- Specify whether you want the text to be rendered with strikethrough (true)
				-- or not for this tab.  The default is false.
				strikethrough = false,
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = '#1b1032',
				fg_color = '#808080',

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over inactive tabs
			inactive_tab_hover = {
				bg_color = '#3b3052',
				fg_color = '#909090',
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab_hover`.
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = '#1b1032',
				fg_color = '#808080',

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = '#3b3052',
				fg_color = '#909090',
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab_hover`.
			},
		},
	}
	--[[ 	config.colors = {
		tab_bar = {
			background = '#333333',

			active_tab = {
				fg_color = '#ffffff',
				bg_color = '#444444',
			},

			new_tab = {
				bg_color = '#333333',
				fg_color = '#ffffff',
			},

			new_tab_hover = {
				bg_color = '#555555',
				fg_color = '#ffffff',
			},
		},
	} ]]

	local window_min = ' 󰖰 '
	local window_max = ' 󰖯 '
	local window_close = ' 󰅖 '

	config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
	config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
	config.tab_bar_style = {
		window_hide = window_min,
		window_hide_hover = window_min,
		window_maximize = window_max,
		window_maximize_hover = window_max,
		window_close = window_close,
		window_close_hover = window_close,
	}

	-- makes the tabbar look more like TUI
	config.use_fancy_tab_bar = false

	config.window_frame = {
		border_left_width = '4px',
		border_right_width = '4px',
		border_bottom_height = '4px',
		border_left_color = config.colors.tab_bar.background,
		border_right_color = config.colors.tab_bar.background,
		border_bottom_color = config.colors.tab_bar.background,
		border_top_color = config.colors.tab_bar.background,
	}
end

return M
