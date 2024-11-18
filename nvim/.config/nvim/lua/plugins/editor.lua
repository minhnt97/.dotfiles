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
		-- smart window resize
		"mrjones2014/smart-splits.nvim",
		config = function()
			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
		end,
	},
	{
		-- view undo tree
		"mbbill/undotree",
		config = function()
			vim.g.undotree_WindowLayout = 2
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
}
