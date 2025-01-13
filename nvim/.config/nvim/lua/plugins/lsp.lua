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
				"clangd",
				"lemminx",
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
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {
			auto_close = true,
			auto_open = true,
			auto_jump = false,
			keys = {
				J = "next",
				K = "prev",
			},
			modes = {
				lsp_references = {
					params = {
						include_declaration = false,
					},
				},
				lsp_base = {
					params = {
						include_current = true,
					},
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
}
