local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
local smart_splits = wezterm.plugin.require("https://github.com/smart-splits-nvim/backend-wezterm")
-- default program
config.default_prog = { "pwsh", "-nologo" }

-- autuload config
config.automatically_reload_config = true

-- appearance
config.term = "xterm-256color"
config.color_scheme_dirs = { os.getenv("HOMEPATH") .. "/.dotfiles/wezterm" }
config.color_scheme = "oxide"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.font_size = 10.50
config.window_padding = {
	left = 5,
	right = 5,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- tab manage
config.switch_to_last_active_tab_when_closing_tab = true

-- Keys
config.leader = {
	key = "s",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

config.keys = {
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},

	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action.Search({ CaseInSensitiveString = "" }),
	},

	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},

	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for window",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{
		key = "w",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},

	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for this workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},

	{
		key = "W",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter name for new workspace",
			action = wezterm.action_callback(function(window, pane, line)
				if line and #line > 0 then
					wezterm.perform_action(act.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},

	{
		key = "&",
		mods = "LEADER|SHIFT",
		action = act.CloseCurrentTab({ confirm = true }),
	},

	{
		key = "s",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "v",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Space",
		mods = "LEADER",
		action = act.RotatePanes("CounterClockwise"),
	},

	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
}

-- navigate between tabs by index
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "META",
	},
	at_edge = "stop",
	block_nav_on_zoom = true,
	log_level = "info", -- 'error' | 'warn' | 'info'
})

return config
