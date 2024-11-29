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
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "(LSP) Toggle inlay hint display" })
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "(LSP) Display signature help" })

			-- mappings for code navigations
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "(LSP) Go to declaration" })
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
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			-- mappings for code navigations
			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", { desc = "(LSP) Hover" })

			-- mappings for code actions
			vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "(LSP) Rename" })
			vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "(LSP) Code actions" })

			-- mappings for diagnostics
			vim.keymap.set(
				"n",
				"]d",
				"<cmd>Lspsaga diagnostic_jump_next<CR>",
				{ desc = "(LSP) Go to next diagnostic position" }
			)
			vim.keymap.set(
				"n",
				"[d",
				"<cmd>Lspsaga diagnostic_jump_prev<CR>",
				{ desc = "(LSP) Go to prev diagnostic position" }
			)
			vim.keymap.set(
				"n",
				"<leader>ee",
				"<cmd>:Lspsaga show_workspace_diagnostics ++float<CR>",
				{ desc = "(LSP) Open workspace diagnostic list" }
			)
			vim.keymap.set(
				"n",
				"<leader>eE",
				"<cmd>:Lspsaga show_buf_diagnostics ++float<CR>",
				{ desc = "(LSP) Open buffer diagnostic list" }
			)
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
				},
				coda_action = {
					extend_gitsigns = true,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
