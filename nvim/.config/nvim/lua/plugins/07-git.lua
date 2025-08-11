return {
	{
		-- working with hunks
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				attach_to_untracked = true,
				sign_priority = 90,
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},
			})
		end,
	},
	{
		-- view git diff
		"sindrets/diffview.nvim",
		config = function()
			local actions = require("diffview.actions")
			vim.opt.fillchars:append({ diff = "╱" })
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					default = {
						-- Config for changed files, and staged files in diff views.
						layout = "diff2_horizontal",
						disable_diagnostics = true,
					},
				},
				file_panel = {
					win_config = { -- See |diffview-config-win_config|
						type = "split",
						position = "bottom",
						height = 15,
						win_opts = {},
					},
				},
				keymaps = {
					file_panel = {
						{ "n", "J", actions.select_next_entry, { desc = "Open the diff for the next file" } },
						{ "n", "K", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
						{ "n", "q", [[<Cmd>DiffviewClose<CR>]], { desc = "Close diff view" } },
					},
				},
			})
		end,
	},
	{
		-- enhanced control of git
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		config = function()
			require("neogit").setup({})
		end,
	},
}
