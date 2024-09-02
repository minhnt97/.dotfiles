return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({})
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
				},
			})
		end,
	},
}
