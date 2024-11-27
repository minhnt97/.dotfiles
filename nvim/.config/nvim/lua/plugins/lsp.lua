return {
	{
		-- auto config LSPs
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},

		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				"lua_ls",
				"bashls",
				"pyright",
				"cmake",
				"clangd",
				"biome",
			}

			-- install mason
			require("mason").setup({
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},
			})

			-- ensure these servers are installed by mason
			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})

			-- setup servers
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					-- on_attach = my_custom_on_attach,
					capabilities = capabilities,
				})
			end

			-- disable diagnostics display to use tiny line
			vim.diagnostic.config({ virtual_text = false })

			-- mappings for LSP display
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, {})
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, {})

			-- mappings for code navigations
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})

			-- mappings for actions
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			-- mappings for diagnostics
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "<leader>ge", function()
				vim.diagnostic.setqflist()
				vim.cmd.copen()
			end, {})
		end,
	},
	{
		"dnlhc/glance.nvim",
		config = function()
			-- mappings for code navigations
			vim.keymap.set("n", "gd", "<cmd>Glance definitions<CR>", {})
			vim.keymap.set("n", "<leader>gr", "<cmd>Glance references<CR>", {})
			vim.keymap.set("n", "gi", "<cmd>Glance implementations<CR>", {})
			vim.keymap.set("n", "<leader>gt", "<cmd>Glance type_definitions<CR>", {})

			require("glance").setup({})
		end,
	},
}
