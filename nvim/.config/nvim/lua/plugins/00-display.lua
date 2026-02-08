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
					lualine_b = { "branch" },
					lualine_c = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
						},
						"selectioncount",
					},
					lualine_x = {
						"lspstatus",
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
}
