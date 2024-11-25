return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			vim.keymap.set("n", "<leader>gf", conform.format, {})
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					json = { "prettierd", "prettier", stop_after_first = true },
				},
			})
		end,
	},
}
