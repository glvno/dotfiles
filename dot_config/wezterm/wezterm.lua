local wezterm = require 'wezterm'
local act = wezterm.action
return {
	color_scheme = "nord",
	font = wezterm.font 'JetBrainsMono Nerd Font',
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		-- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
		{
			key = 'a',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'a',
				mods = 'CTRL',
			},
		},
		{
			key = 'd',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'd',
				mods = 'CTRL',
			},
		},
		{
			key = 'i',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'i',
				mods = 'CTRL',
			},
		},
		{
			key = 'k',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'k',
				mods = 'CTRL',
			},
		},
		{
			key = 'o',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'o',
				mods = 'CTRL',
			},
		},
		{
			key = 'r',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'r',
				mods = 'CTRL',
			},
		},
		{
			key = 'u',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'u',
				mods = 'CTRL',
			},
		},
		{
			key = 'y',
			mods = 'SUPER',
			action = act.SendKey {
				key = 'y',
				mods = 'CTRL',
			},
		},
	},
}
