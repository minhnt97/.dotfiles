return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("kanagawa-paper-ink")
		end,
		config = function()
			require("kanagawa-paper").setup({
				dim_inactive = true,
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				presets = {
					lsp_doc_border = true,
				},
			})
		end,
	},
	{
		-- change status line display
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("nvim-navic").setup({
						highlight = true,
						depth_limit = 0,
						lsp = {
							auto_attach = true,
						},
					})
				end,
			},
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
						},
						"selectioncount",
					},
					lualine_c = {
						{
							"filename",
							filestatus = true,
							newfile_status = true,
							path = 0,
							shorting_target = 80,
						},
						{
							"navic",
							-- Component specific options
							color_correction = "dynamic", -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
							-- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
							-- Setting it to "static" will perform a adjustment once when the component is being setup. This should
							--   be enough when the lualine section isn't changing colors based on the mode.
							-- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
							--   the current section.

							navic_opts = nil, -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
						},
					},
					lualine_x = { "lspstatus" },
					lualine_y = {},
					lualine_z = { "progress", "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							filestatus = true,
							newfile_status = true,
							path = 0,
							shorting_target = 80,
						},
					},
					lualine_x = { "progress", "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{
		-- auto hightlights same word under cursor
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			require("ufo").setup({})
		end,
	},
}
