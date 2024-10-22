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

			-- mappings for code navigations
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})

			-- mappings for workspace manage
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {})
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {})
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, {})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			local lspsaga = require("lspsaga")
			lspsaga.setup({
				definition = {
					width = 0.6,
					height = 0.6,
					keys = {
						vsplit = "<C-c>v",
						split = "<C-c>s",
					},
				},
				finder = {
					max_height = 0.4,
					left_width = 0.35,
					right_width = 0.65,
					layout = "normal",
					keys = {
						vsplit = "v",
						split = "s",
					},
				},
				outline = {
					win_width = 60,
					close_after_jump = true,
				},
			})
			-- mappings for code navigations
			vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", {})
			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", {})
			vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", {})
			vim.keymap.set("n", "<leader>pD", "<cmd>Lspsaga peek_type_definition<CR>", {})
			vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga finder ref+imp<CR>", {}) -- find references + implementation
			vim.keymap.set("n", "<leader>gR", "<cmd>Lspsaga finder def+ref+imp<CR>", {}) -- find definition + references + implementation
			vim.keymap.set("n", "<leader>oo", "<cmd>Lspsaga outline<CR>", {})

			-- mappings for diagnostics
			vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {})
			vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", {})
			vim.keymap.set("n", "<leader>ge", "<cmd>Lspsaga show_line_diagnostics<CR>", {})
			vim.keymap.set("n", "<leader>gE", "<cmd>Lspsaga show_buf_diagnostics<CR>", {})

			-- mappings for changes using LSP
			vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename <CR>", {})
			vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", {})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
