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
			vim.keymap.set("n", "<C-w>_", cmd("WindowsMaximizeVertically"))
			vim.keymap.set("n", "<C-w>|", cmd("WindowsMaximizeHorizontally"))
			vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))
			require("windows").setup()
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
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
}
