return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local telescope_builtin = require("telescope.builtin")
			local lga_actions = require("telescope-live-grep-args.actions")
			local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

			-- mappings for file search
			vim.keymap.set("n", "<leader>ff", function()
				telescope_builtin.find_files({
					hidden = true,
					no_ignore = true,
				})
			end, {})
			vim.keymap.set("n", "<leader>fe", function()
				require("telescope").extensions.file_browser.file_browser()
			end, {})
			vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
			vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, {})

			-- mappings for text search
			vim.keymap.set("n", "<leader>fg", function()
				telescope.extensions.live_grep_args.live_grep_args({})
			end, {})
			vim.keymap.set("n", "<leader>fw", function()
				live_grep_args_shortcuts.grep_word_under_cursor({
					postfix = "",
					qoute = false,
				})
			end, {})

			-- mappings for vim
			vim.keymap.set("n", "<leader>fr", telescope_builtin.registers, {})
			vim.keymap.set("n", "<leader>fm", telescope_builtin.keymaps, {})

			-- mappings for symbols search using LSP
			vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>fa", telescope_builtin.lsp_dynamic_workspace_symbols, {})

			-- setup everything
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							prompt_position = "top",
						},
					},
				},
				pickers = {
					find_files = {
						mappings = {
							n = {
								["cd"] = function(prompt_bufnr)
									local selection = require("telescope.actions.state").get_selected_entry()
									local dir = vim.fn.fnamemodify(selection.path, ":p:h")
									require("telescope.actions").close(prompt_bufnr)
									-- Depending on what you want put `cd`, `lcd`, `tcd`
									vim.cmd(string.format("silent lcd %s", dir))
								end,
							},
						},
					},
					lsp_document_symbols = {
						symbol_width = 50,
					},
					lsp_dynamic_workspace_symbols = {
						fname_width = 50,
					},
					lsp_references = {
						fname_width = 50,
						include_current_line = true,
						trim_text = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						-- theme = "ivy",
					},
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-h>"] = lga_actions.quote_prompt({
									postfix = " --hidden --no-ignore ",
								}),
								["<C-g>"] = lga_actions.quote_prompt({
									postfix = " --iglob ",
								}),
								["<C-t>"] = lga_actions.quote_prompt({
									postfix = " -t ",
								}),
								-- freeze the current list and start a fuzzy search in the frozen list
								["<C-space>"] = lga_actions.to_fuzzy_refine,
							},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("ui-select")
			telescope.load_extension("file_browser")
		end,
	},
}
