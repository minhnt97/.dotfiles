local wezterm                                     = require("wezterm")
local act                                         = wezterm.action
local config                                      = wezterm.config_builder()

-- default program
config.default_prog                               = { "pwsh", "-nologo" }

-- autuload config
config.automatically_reload_config                = true

-- appearance
config.term                                       = "xterm-256color"
config.color_scheme_dirs                          = { wezterm.home_dir .. "/.dotfiles/wezterm" }
config.color_scheme                               = 'kanagawa-paper-ink'
config.font                                       = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold" })
config.font_size                                  = 10
config.window_padding                             = {
        left = 5,
        right = 5,
        top = 0,
        bottom = 0,
}
config.window_decorations                         = "RESIZE"
config.tab_bar_at_bottom                          = true
config.use_fancy_tab_bar                          = true
config.tab_max_width                              = 32
config.hide_tab_bar_if_only_one_tab               = true
config.inactive_pane_hsb                          = {
        saturation = 1.0,
        brightness = 0.9,
}

-- tab manage
config.switch_to_last_active_tab_when_closing_tab = true

-- Keys
config.leader                                     = {
        key = "s",
        mods = "CTRL",
        timeout_milliseconds = 2000,
}

-- integration with nvim
local function is_vim(pane)
        -- this is set by the plugin, and unset on ExitPre in Neovim
        return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
        h = "Left",
        j = "Down",
        k = "Up",
        l = "Right",
}

local function split_nav(resize_or_move, key)
        return {
                key = key,
                mods = resize_or_move == "resize" and "META" or "CTRL",
                action = wezterm.action_callback(function(win, pane)
                        if is_vim(pane) then
                                -- pass the keys through to vim/nvim
                                win:perform_action({
                                        SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
                                }, pane)
                        else
                                if resize_or_move == "resize" then
                                        win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                                else
                                        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                                end
                        end
                end),
        }
end

config.keys = {
        {
                key = "[",
                mods = "LEADER",
                action = wezterm.action.ActivateCopyMode,
        },

        {
                key = "]",
                mods = "LEADER",
                action = wezterm.action.Search({ CaseInSensitiveString = '' })
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
                action = act.ShowTabNavigator,
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

        -- move between split panes
        split_nav("move", "h"),
        split_nav("move", "j"),
        split_nav("move", "k"),
        split_nav("move", "l"),

        -- resize panes
        split_nav("resize", "h"),
        split_nav("resize", "j"),
        split_nav("resize", "k"),
        split_nav("resize", "l"),

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

return config
