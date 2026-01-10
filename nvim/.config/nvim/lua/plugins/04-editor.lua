return {
	{
		"arnamak/stay-centered.nvim",
	},
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
		lazy = false,
		priority = 1000,
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
		-- commenting codes
		"numToStr/Comment.nvim",
		config = true,
	},
}
