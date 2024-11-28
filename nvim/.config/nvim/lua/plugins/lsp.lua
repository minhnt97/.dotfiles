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
					capabilities = capabilities,
				})
			end

			-- disable diagnostics display to use tiny line
			vim.diagnostic.config({ virtual_text = false })

			-- mappings for LSP display
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "(LSP) Hover" })
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "(LSP) Toggle inlay hint display" })
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "(LSP) Display signature help" })

			-- mappings for code navigations
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "(LSP) Go to declaration" })

			-- mappings for actions
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "(LSP) Rename" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "(LSP) Code actions" })

			-- mappings for diagnostics
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "(LSP) Go to next diagnostic position" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "(LSP) Go to prev diagnostic position" })
			vim.keymap.set("n", "<leader>ee", function()
				vim.diagnostic.setqflist()
				vim.cmd.copen()
			end, { desc = "(LSP) Open diagnostic list" })
		end,
	},
	{
		"dnlhc/glance.nvim",
		config = function()
			-- mappings for code navigations
			vim.keymap.set("n", "gd", "<cmd>Glance definitions<CR>", { desc = "(LSP) Go to definitions" })
			vim.keymap.set("n", "gr", "<cmd>Glance references<CR>", { desc = "(LSP) Go to references" })
			vim.keymap.set("n", "gi", "<cmd>Glance implementations<CR>", { desc = "(LSP) Go to implementations" })
			vim.keymap.set(
				"n",
				"<leader>gt",
				"<cmd>Glance type_definitions<CR>",
				{ desc = "(LSP) Go to type_definitions" }
			)

			require("glance").setup({})
		end,
	},
}
