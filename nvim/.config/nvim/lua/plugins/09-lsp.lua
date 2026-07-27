return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},
			})
			require("mason-lspconfig").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		specs = {
			"folke/snacks.nvim",
			opts = function(_, opts)
				return vim.tbl_deep_extend("force", opts or {}, {
					picker = {
						actions = require("trouble.sources.snacks").actions,
						win = {
							input = {
								keys = {
									["<c-t>"] = {
										"trouble_open",
										mode = { "n", "i" },
									},
								},
							},
						},
					},
				})
			end,
		},
		opts = {
			auto_refresh = false, -- auto refresh when open
			auto_close = true, -- auto close when there are no items
			auto_jump = true, -- auto jump to the item when there's only one
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
		},
		cmd = "Trouble",
	},
}
