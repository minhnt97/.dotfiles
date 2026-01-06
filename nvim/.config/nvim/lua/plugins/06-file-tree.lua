return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		case_insensitive = true,
		config = function()
			-- Declare a global function to retrieve the current directory
			function _G.get_oil_winbar()
				local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
				local dir = require("oil").get_current_dir(bufnr)
				if dir then
					return vim.fn.fnamemodify(dir, ":~")
				else
					-- If there is no current directory (e.g. over ssh), just show the buffer name
					return vim.api.nvim_buf_get_name(0)
				end
			end

			require("oil").setup({
				columns = {
					"mtime",
					"type",
					"size",
					"icon",
				},
				use_default_keymaps = false,
				watch_for_changes = true,
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["l"] = "actions.select",
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
					["<C-x>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["q"] = { "actions.close", mode = "n" },
					["<C-r>"] = "actions.refresh",
					["h"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
				},
			})
		end,
	},
}
