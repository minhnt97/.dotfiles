return {
	{
		-- manage LSP installation
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		-- connect mason and lspconfig
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"pyright",
					"cmake",
				},
			})
		end,
	},
	{
		-- auto config LSPs
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- setup LSP servers
			lspconfig.lua_ls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.clangd.setup({})
			lspconfig.pyright.setup({})
			lspconfig.cmake.setup({})

			-- mappings for code navigations
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		-- diagnostics navigate
		"folke/trouble.nvim",
		opts = {
			modes = {
				lsp_base = {
					params = {
						include_current = true,
					},
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>ge",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>gE",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>gr",
				"<cmd>Trouble lsp_references toggle focus=true win.position=bottom<cr>",
				desc = "LSP references (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble loclist toggle focus=true<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle focus=true<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		-- prettier diagnostics display
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		config = function()
			vim.diagnostic.config({ virtual_text = false })
			require("tiny-inline-diagnostic").setup()
		end,
	},
}
