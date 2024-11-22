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
			}

			-- install mason
			require("mason").setup({})

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
