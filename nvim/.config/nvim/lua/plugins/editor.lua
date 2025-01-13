return {
	{
		-- edit surrounding symbols
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		-- manual sane window resize & move between panes
		"mrjones2014/smart-splits.nvim",
		opts = {},
	},
	{
		-- auto resize windows with animation
		"anuvyklack/windows.nvim",
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
		-- for better workflow
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		-- commenting codes
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		-- disable plugins in big files
		"LunarVim/bigfile.nvim",
		opts = {},
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
		end,
		ft = { "markdown" },
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
			})

			vim.api.nvim_create_autocmd({
				"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
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
