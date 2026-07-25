return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			local servers = {
				"lua_ls",
				"clangd",
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

			-- configure all LSPs
			local capabilities = {
				textDocument = {
					semanticTokens = {
						multilineTokenSupport = true,
					},
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			}

			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- specific configuration
			vim.lsp.config["clangd"] = {
				settings = {
					cmd = {
						"clangd",
						"--background-index",
						"--offset-encoding=utf-8",
						"--clang-tidy",
						"--header-insertion=never",
						"--limit-references=0",
						"--limit-results=0",
						"--rename-file-limit=0",
					},
					filetypes = { "c", "cpp" },
				},
			}

			-- enable server
			for _, lsp in ipairs(servers) do
				vim.lsp.enable(lsp)
			end

			-- disable diagnostics display to use tiny line
			vim.diagnostic.config({ virtual_text = false })
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
