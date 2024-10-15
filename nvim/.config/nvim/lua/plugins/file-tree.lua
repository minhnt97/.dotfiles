return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- mappings
			vim.keymap.set("n", "<leader>ef", ":Neotree toggle current reveal_force_cwd<cr>", {})
			vim.keymap.set("n", "<leader>el", ":Neotree toggle reveal left<cr>", {})

			require("neo-tree").setup({})
		end,
	},
}
