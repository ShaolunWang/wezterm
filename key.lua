local wezterm = require('wezterm')

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
	h = 'Left',
	j = 'Down',
	k = 'Up',
	l = 'Right',
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = 'CTRL',
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = 'CTRL' },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
			end
		end),
	}
end

return {
	-- move between split panes
	split_nav('move', 'h'),
	split_nav('move', 'j'),
	split_nav('move', 'k'),
	split_nav('move', 'l'),
	-- split panes
	{
		key = 'a',
		mods = 'LEADER',
		action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
	},
	{
		key = 'v',
		mods = 'LEADER',
		action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
	},
	{
		key = 'r',
		mods = 'LEADER|CTRL',
		action = wezterm.action.PromptInputLine({
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{ key = 'c',   mods = 'LEADER',       action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) },
	{
		key = 'v',
		mods = 'CTRL|SHIFT',
		action = wezterm.action({ PasteFrom = 'Clipboard' }),
	},
	{ key = 'H',   mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Left', 5 } }) },
	{ key = 'J',   mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Down', 5 } }) },
	{ key = 'K',   mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Up', 5 } }) },
	{ key = 'L',   mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Right', 5 } }) },
	{ key = 'x',   mods = 'LEADER',       action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = '+',   mods = 'SHIFT|CTRL',   action = 'IncreaseFontSize' },
	{ key = '_',   mods = 'SHIFT|CTRL',   action = 'DecreaseFontSize' },
	{ key = '0',   mods = 'SHIFT|CTRL',   action = 'ResetFontSize' },
	{ key = 'Tab', mods = 'LEADER',       action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = 'Tab', mods = 'LEADER|CTRL',  action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "1",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9",   mods = "LEADER",       action = wezterm.action({ ActivateTab = 8 }) },
}
