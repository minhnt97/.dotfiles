local function scoll_preview(keys)
	return function()
		local p = require("trouble.view.preview").preview
		if p and vim.api.nvim_win_is_valid(p.win) then
			vim.api.nvim_win_call(p.win, function()
				vim.cmd("normal! " .. keys)
			end)
		end
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"saghen/blink.cmp",
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
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
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
			auto_jump = false, -- auto jump to the item when there's only one
			win = {
				type = "float",
				relative = "editor",
				position = { 0.5, 0 },
				border = "rounded",
				size = { height = 0.6, width = 0.5 },
				focusable = true,
			},
			preview = {
				type = "float",
				relative = "editor",
				position = { 0.5, 1 },
				border = "rounded",
				size = {
					height = 0.6,
					width = 0.5,
				},
				scratch = true,
			},
			keys = {
				J = "next",
				K = "prev",
				["<c-d>"] = scoll_preview("\4"),
				["<c-u>"] = scoll_preview("\21"),
				["<c-e>"] = scoll_preview("\5"),
				["<c-y>"] = scoll_preview("\25"),
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
