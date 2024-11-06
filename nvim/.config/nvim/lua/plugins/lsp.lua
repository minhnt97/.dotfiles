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

			-- disable diagnostics display to use tiny line
			vim.diagnostic.config({ virtual_text = false })

			-- mappings for LSP display
			vim.keymap.set("n", "<leader>gh", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, {})

			-- mappings for code navigations
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
		end,
	},
	{
		"dnlhc/glance.nvim",
		config = function()
			-- mappings for code navigations
			vim.keymap.set("n", "gd", "<cmd>Glance definitions<CR>", {})
			vim.keymap.set("n", "<leader>gt", "<cmd>Glance type_definitions<CR>", {})
			vim.keymap.set("n", "<leader>gr", "<cmd>Glance references<CR>", {})
			vim.keymap.set("n", "gi", "<cmd>Glance implementations<CR>", {})

			require("glance").setup({})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			-- mappings for code navigations
			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", {})

			-- mappings for code actions
			vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", {})
			vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", {})

			-- mappings for diagnostics
			vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", {})
			vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {})
			vim.keymap.set("n", "<leader>ge", "<cmd>:Lspsaga show_workspace_diagnostics ++float<CR>", {})
			vim.keymap.set("n", "<leader>gE", "<cmd>:Lspsaga show_buf_diagnostics ++float<CR>", {})
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		-- prettier diagnostics display
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach", -- Or `LspAttach`
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					throttle = 200,
				},
			})
		end,
	},
}
