return {
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = "browser",
				theme = "light",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		ft = "markdown",
		lazy = false,
		---@module 'obsidian'
		---@type obsidian.config
		opts = {
			legacy_commands = false, -- this will be removed in the next major release
			workspaces = {
				{
					name = "personal",
					path = "~/notes/personal",
				},
				{
					name = "work",
					path = "~/notes/work",
				},
			},
		},
	},
	{
		"SCJangra/table-nvim",
		ft = "markdown",
		opts = {
			padd_column_separators = true, -- Insert a space around column separators.
			mappings = { -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
				next = "<TAB>", -- Go to next cell.
				prev = "<S-TAB>", -- Go to previous cell.
				insert_row_up = "<leader>tk", -- Insert a row above the current row.
				insert_row_down = "<leader>tj", -- Insert a row below the current row.
				move_row_up = "<leader>tK", -- Move the current row up.
				move_row_down = "<leader>tJ", -- Move the current row down.
				insert_column_left = "<leader>th", -- Insert a column to the left of current column.
				insert_column_right = "<leader>tl", -- Insert a column to the right of current column.
				move_column_left = "<leader>tH", -- Move the current column to the left.
				move_column_right = "<leader>tL", -- Move the current column to the right.
				insert_table = "<leader>tt", -- Insert a new table.
				insert_table_alt = "<leader>tT", -- Insert a new table that is not surrounded by pipes.
				delete_column = "<leader>td", -- Delete the column under cursor.
			},
		},
	},
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			-- configuration here or empty for defaults
		},
	},
}
