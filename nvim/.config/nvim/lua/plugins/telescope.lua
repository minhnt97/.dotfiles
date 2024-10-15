return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope_builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", function()
				telescope_builtin.find_files({
					hidden = true,
					no_ignore = true,
				})
			end, {})
			-- mappings for search-related actions
			vim.keymap.set("n", "<leader>fw", telescope_builtin.grep_string, {})
			vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fr", telescope_builtin.registers, {})

			-- mappings LSP actions
			vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>fa", telescope_builtin.lsp_dynamic_workspace_symbols, {})
			vim.keymap.set("n", "<leader>gr", telescope_builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>ge", telescope_builtin.diagnostics, {})

			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					file_browser = {
						theme = "ivy",
					},
				},
			})

			vim.keymap.set("n", "<leader>fb", function()
				require("telescope").extensions.file_browser.file_browser()
			end, {})

			telescope.load_extension("file_browser")
		end,
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		-- This will not install any breaking changes.
		-- For major updates, this must be adjusted manually.
		version = "^1.0.0",
		config = function()
			local telescope = require("telescope")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({
									postfix = " --iglob ",
								}),
								-- freeze the current list and start a fuzzy search in the frozen list
								-- ["<C-space>"] = actions.to_fuzzy_refine,
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},
				},
			})

			vim.keymap.set("n", "<leader>fg", function()
				telescope.extensions.live_grep_args.live_grep_args()
			end, {})

			-- then load the extension
			telescope.load_extension("live_grep_args")
		end,
	},
}
