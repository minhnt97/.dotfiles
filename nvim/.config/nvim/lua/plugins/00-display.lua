return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa-paper").setup({
				dim_inactive = true,
				gutter = true,
				cache = true,
				overrides = function(colors)
					return {
						["@lsp.type.comment"] = { fg = colors.theme.syn.comment },
					}
				end,
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
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				presets = {
					lsp_doc_border = true,
				},
			})
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
					lualine_b = { "branch", "selectioncount" },
					lualine_c = {
						{
							"filename",
							path = 5,
						},
					},
					lualine_x = {
						"filetype",
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
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
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}
