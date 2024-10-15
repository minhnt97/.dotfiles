return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			-- mappings
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- prettier for many languages
					null_ls.builtins.formatting.prettier,
					-- lua
					null_ls.builtins.formatting.stylua,
					-- python
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.black,
				},
			})
		end,
	},
}
