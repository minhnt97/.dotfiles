return {
	{
		-- edit surrounding symbols
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		-- navigate between nvim and tmux
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true,
			})
		end,
	},
	{
		-- manual sane window resize
		"mrjones2014/smart-splits.nvim",
		config = function()
			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
		end,
	},
	{
		-- auto resize windows with animation
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false

			local function cmd(command)
				return table.concat({ "<Cmd>", command, "<CR>" })
			end

			vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"))
			vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))
			require("windows").setup()
		end,
	},
	{
		-- view undo tree
		"mbbill/undotree",
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
		end,
	},
	{
		-- auto remove search highlights
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		config = function()
			require("hlsearch").setup()
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
					priority = 10,
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
				exclude = {},
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
		-- for quickfix preview
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			-- mappings for quickfix
			vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", {})
			vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", {})
			vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", {})
			vim.keymap.set("n", "<leader>cp", "<cmd>cprevious<CR>", {})

			-- mappings for location list
			vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", {})
			vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", {})
			vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>", {})
			vim.keymap.set("n", "<leader>lp", "<cmd>lprevious<CR>", {})
		end,
	},
	{
		-- for fzf during quickfix navigate
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
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
		-- for better workflow
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("hardtime").setup()
		end,
	},
	{
		-- commenting codes
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		-- disable plugins in big files
		"LunarVim/bigfile.nvim",
	},
	{
		-- preview markdown using browser
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		lazy = false,
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_combine_preview = 1
			vim.g.mkdp_command_for_global = 1
			vim.g.mkdp_filetypes = { "markdown", "puml" }
			vim.keymap.set("n", "<leader>p", "<cmd>MarkdownPreviewToggle<cr>", {})
		end,
		ft = { "markdown" },
	},
}
