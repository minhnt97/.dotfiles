return {
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_enable_italic = false
			vim.g.sonokai_disable_italic_comment = 1
			vim.g.sonokai_dim_inactive_windows = 1
			vim.g.sonokai_inlay_hints_background = "dimmed"
			vim.g.sonokai_style = "espresso"
			-- vim.cmd.colorscheme("sonokai")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = false
			vim.g.gruvbox_material_disable_italic_comment = 1
			vim.g.gruvbox_material_dim_inactive_windows = 1
			vim.g.gruvbox_material_inlay_hints_background = "dimmed"
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		-- change status line display
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = {
						{
							"filename",
							path = 1, -- 1: Relative path
						},
					},

					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },

					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		-- change cursor line & number display
		"mawkler/modicator.nvim",
		opts = {
			-- Warn if any required option above is missing. May emit false positives
			-- if some other plugin modifies them, which in that case you can just
			-- ignore. Feel free to remove this line after you've gotten Modicator to
			-- work properly.
			show_warnings = true,
		},
	},
	{
		-- display dashboard when nvim starts
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
