return {
	{
		-- hightlight codes
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		lazy = false,
		build = ":TSUpdate",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "markdown", "markdown_inline" },
				auto_install = true,
				highlight = { enable = true },
			})
		end,
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
				overrides = function(colors)
					return {
						-- use comment color
						["@lsp.type.comment"] = { fg = colors.theme.syn.comment },

						-- remove the strikethrough
						DiffDelete = {
							bg = colors.theme.diff.delete_light,
							fg = colors.theme.vcs.removed,
							strikethrough = false,
						},
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
							path = 1,
							shorting_target = 80,
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
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			-- triggers CursorHold event faster
			vim.opt.updatetime = 200

			require("barbecue").setup({
				create_autocmd = false, -- prevent barbecue from updating itself automatically
				exclude_filetypes = { "netrw", "toggleterm", "diffview" },
				show_dirname = false,
				show_modified = true,
			})

			vim.api.nvim_create_autocmd({
				"WinResized", -- or WinResized on NVIM-v0.9 and higher
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",

				-- include this if you have set `show_modified` to `true`
				"BufModifiedSet",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
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
