return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["l"] = "actions.select",
				["v"] = { "actions.select", opts = { vertical = true } },
				["s"] = { "actions.select", opts = { horizontal = true } },
				["t"] = { "actions.select", opts = { tab = true } },
				["p"] = "actions.preview",
				["q"] = { "actions.close", mode = "n" },
				["r"] = "actions.refresh",
				["h"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
}
