return {
	{
		-- working with hunks
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				numhl = true,
				current_line_blame = true,
				attach_to_untracked = true,
				sign_priority = 6,
				diff_opts = {
					algorithm = "patience",
				},
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},
			})
		end,
	},
	{
		"esmuellert/codediff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "CodeDiff",
		opts = {
			-- Explorer panel configuration
			explorer = {
				position = "bottom", -- "left" or "bottom"
				height = 10, -- Height when position is "bottom" (lines)
			},
		},
	},
}
