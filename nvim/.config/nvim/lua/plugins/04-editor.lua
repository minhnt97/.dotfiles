return {
	{
		"arnamak/stay-centered.nvim",
		event = "VeryLazy",
	},
	{
		-- edit surrounding symbols
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"smart-splits-nvim/smart-splits.nvim",
		version = "^3.0.0",
		opts = {
			mux = {
				backend = {
					"smart-splits-backend-tmux",
					"smart-splits-backend-wezterm",
				},
			},
			move = {
				at_edge = "stop",
			},
			swap = {
				move_cursor = false,
			},
		},
		dependencies = {
			{
				"smart-splits-nvim/backend-wezterm",
				opts = {
					-- name/path of the wezterm binary; used only by :checkhealth's diagnostic version probe,
					-- never on any hot path (see "How it works")
					cli_path = "wezterm",
				},
			},
			{
				"smart-splits-nvim/backend-tmux",
				main = "smart-splits-backend-tmux",
			},
		},
	},
	{
		-- auto resize windows with animation
		"anuvyklack/windows.nvim",
		event = "VeryLazy",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 5
			vim.o.winminwidth = 5
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},
	{
		-- undo tree
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},
	{
		-- auto remove search highlights
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		config = true,
	},
	{
		-- commenting codes
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"toppair/peek.nvim",
		ft = "markdown",
		cmd = { "PeekOpen", "PeekClose" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = "browser",
				theme = "light",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
