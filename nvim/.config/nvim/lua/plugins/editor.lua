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
			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize window left" })
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize window down" })
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize window up" })
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize window right" })
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

			vim.keymap.set("n", "<C-w>z", cmd("WindowsMaximize"), { desc = "Resize window right" })
			vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"), { desc = "Resize window right" })
			require("windows").setup()
		end,
	},
	{
		-- undo tree
		"mbbill/undotree",
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Resize window right" })
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
		-- for quickfix preview
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			-- mappings for quickfix
			vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix list" })
			vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })
			vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Move to next quickfix position" })
			vim.keymap.set("n", "<leader>cp", "<cmd>cprevious<CR>", { desc = "Move to previous quickfix position" })

			-- mappings for location list
			vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
			vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })
			vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>", { desc = "Move to next location list" })
			vim.keymap.set("n", "<leader>lp", "<cmd>lprevious<CR>", { desc = "Move to previous location list" })
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
			vim.keymap.set("n", "<leader>p", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview" })
		end,
		ft = { "markdown" },
	},
}
