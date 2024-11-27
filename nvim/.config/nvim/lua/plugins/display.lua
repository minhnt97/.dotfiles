return {
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
			vim.g.gruvbox_material_inlay_hints_background = "none"
			vim.g.gruvbox_material_ui_contrast = "high"
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "material"
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
		-- for quickfix line display
		"yorickpeterse/nvim-pqf",
		config = function()
			require("pqf").setup()
		end,
	},
	{
		-- display rainbow delimeters
		"HiPhish/rainbow-delimiters.nvim",
	},
	{
		-- show guideline for indent
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({
				viewport_buffer = {
					min = 100,
				},
				indent = {
					priority = 8,
					char = "┊",
					smart_indent_cap = true,
					repeat_linebreak = false,
				},
				scope = {
					highlight = highlight,
					show_start = false,
					show_end = false,
					show_exact_scope = false,
				},
				exclude = {
					filetypes = {
						"lspinfo",
						"packer",
						"checkhealth",
						"help",
						"man",
						"gitcommit",
						"TelescopePrompt",
						"TelescopeResults",
						"dashboard",
						"''",
					},
				},
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
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
		-- change cursor line & number display
		"mawkler/modicator.nvim",
		opts = {
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
