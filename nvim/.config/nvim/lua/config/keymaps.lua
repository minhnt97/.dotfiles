local map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = true
	opts.silent = true
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- mappings for moving between splits
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)

-- mappings for manual window resize
map("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize window left" })
map("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize window down" })
map("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize window up" })
map("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize window right" })

-- mappings for swapping buffers between windows
map("n", "<C-w>h", require("smart-splits").swap_buf_left)
map("n", "<C-w>j", require("smart-splits").swap_buf_down)
map("n", "<C-w>k", require("smart-splits").swap_buf_up)
map("n", "<C-w>l", require("smart-splits").swap_buf_right)

-- mappings for moving between tabs
map("n", "<Tab>", "<cmd>tabnext<cr>", { desc = "Next tab", unique = true })
map("n", "<S-Tab>", "<cmd>tabprevious<cr>", { desc = "Previous tab", unique = true })

-- mappings for auto window size toggle
map("n", "<C-w>z", "<cmd>WindowsMaximize<cr>", { desc = "Resize window right" })
map("n", "<C-w>=", "<cmd>WindowsEqualize<cr>", { desc = "Resize window right" })

-- mappings for stay centered
map({ "n", "v" }, "<leader>st", require("stay-centered").toggle, { desc = "Toggle stay centered" })

-- mappings for snacks
local Snacks = require("snacks")

-- Top Pickers
map("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })

map("n", "<leader>/", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })

map("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })

-- Find
map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })

map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })

map("n", "<leader>fg", function()
	Snacks.picker.git_files()
end, { desc = "Find Git Files" })

map("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })

map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })

-- Grep
map("n", "<leader>sg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })

map("n", "<leader>sb", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })

map({ "n", "x" }, "<leader>sw", function()
	Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

-- Search
map("n", '<leader>s"', function()
	Snacks.picker.registers()
end, { desc = "Registers" })

map("n", "<leader>s/", function()
	Snacks.picker.search_history()
end, { desc = "Search History" })

map("n", "<leader>sa", function()
	Snacks.picker.autocmds()
end, { desc = "Autocmds" })

map("n", "<leader>sC", function()
	Snacks.picker.commands()
end, { desc = "Commands" })

map("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })

map("n", "<leader>sH", function()
	Snacks.picker.highlights()
end, { desc = "Highlights" })

map("n", "<leader>si", function()
	Snacks.picker.icons()
end, { desc = "Icons" })

map("n", "<leader>sj", function()
	Snacks.picker.jumps()
end, { desc = "Jumps" })

map("n", "<leader>sk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })

map("n", "<leader>sm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })

map("n", "<leader>sM", function()
	Snacks.picker.man()
end, { desc = "Man Pages" })

map("n", "<leader>sp", function()
	Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })

map("n", "<leader>uC", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })

-- LSP pickers
map("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })

map("n", "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

-- Other
map("n", "<leader>z", function()
	Snacks.zen()
end, { desc = "Toggle Zen Mode" })

map("n", "<leader>Z", function()
	Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })

map("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

map("n", "<leader>S", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename File" })

map("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

map("n", "<c-/>", function()
	Snacks.terminal()
end, { desc = "Toggle Terminal" })

map("n", "<c-_>", function()
	Snacks.terminal()
end, { desc = "which_key_ignore" })

-- mappings for LSP display
map("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "(LSP) Toggle inlay hint display" })

map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "(LSP) Display signature help" })

-- mappings for code actions
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "(LSP) Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "(LSP) Code actions" })

-- mappings for diagnostics
map("n", "<leader>ge", "<cmd>Trouble diagnostics toggle toggle focus=true<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>gE", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "(LSP) Go to next diagnostic position" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "(LSP) Go to prev diagnostic position" })

-- mappings for code navigations
local hover = {
	mapping = "K",
	func = vim.lsp.buf.hover,
	opts = { desc = "(LSP) Hover" },
}
map("n", hover.mapping, hover.func, hover.opts)
map("n", "gd", "<cmd>Trouble lsp_definitions open focus=true<CR>", { desc = "(LSP) Go to definitions" })
map("n", "gD", "<cmd>Trouble lsp_declarations open focus=true<CR>", { desc = "(LSP) Go to declaration" })
map("n", "<leader>gr", "<cmd>Trouble lsp_references open focus=true<CR>", { desc = "(LSP) Go to references" })
map("n", "gi", "<cmd>Trouble lsp_implementations open focus=true<CR>", { desc = "(LSP) Go to implementations" })
map(
	"n",
	"<leader>gt",
	"<cmd>Trouble lsp_type_definitions toggle focus=true<CR>",
	{ desc = "(LSP) Go to type_definitions" }
)

-- generate doxygen
map("n", "<leader>dg", require("neogen").generate, { desc = "Generate doxygen" })

-- mappings for undo tree
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Resize window right" })

-- mappings for quickfix
map("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Move to next quickfix position" })
map("n", "<leader>cp", "<cmd>cprevious<CR>", { desc = "Move to previous quickfix position" })

-- mappings for location list
map("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
map("n", "<leader>ln", "<cmd>lnext<CR>", { desc = "Move to next location list" })
map("n", "<leader>lp", "<cmd>lprevious<CR>", { desc = "Move to previous location list" })

-- mappings for markdown preview
map("n", "<leader>p", function()
	local peek = require("peek")
	if peek.is_open() then
		peek.close()
	else
		peek.open()
	end
end, { desc = "Toggle web markdown preview" })

-- mappings for file tree toggle
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open file tree" })

-- mappings for gitsigns
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map_gitsign(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			map(mode, l, r, opts)
		end

		-- Navigation
		map_gitsign("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "(Gitsigns) Move to next hunk" })

		map_gitsign("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "(Gitsigns) Move to prev hunk" })

		-- Stage/unstage hunk & buffer
		map_gitsign("n", "<leader>hs", gitsigns.stage_hunk, { desc = "(Gitsigns) Stage this hunk" })
		map_gitsign("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "(Gitsigns) Unstage this hunk" })
		map_gitsign("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "(Gitsigns) Stage this hunk" })
		map_gitsign("n", "<leader>hS", gitsigns.stage_buffer, { desc = "(Gitsigns) Stage this buffer" })

		-- Reset hunk & buffer
		map_gitsign("n", "<leader>hr", gitsigns.reset_hunk, { desc = "(Gitsigns) Reset this hunk" })
		map_gitsign("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "(Gitsigns) Reset this hunk" })
		map_gitsign("n", "<leader>hR", gitsigns.reset_buffer, { desc = "(Gitsigns) Restore this buffer" })

		-- Compare hunks , deleted
		map_gitsign("n", "<leader>hp", gitsigns.preview_hunk, { desc = "(Gitsigns) Preview this hunk" })
		map_gitsign("n", "<leader>hd", gitsigns.toggle_deleted, { desc = "(Gitsigns) Toggle deleted sections display" })

		-- Blame
		map_gitsign(
			"n",
			"<leader>lb",
			gitsigns.toggle_current_line_blame,
			{ desc = "(Gitsigns) Toggle current line blame info" }
		)
		map_gitsign("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "(Gitsigns) Display current hunk blame" })

		-- Text object
		map_gitsign({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "(Gitsigns) Select hunk" })
	end,
})

-- mappings for formatting
map("n", "<leader>gf", "<cmd>Format<cr>", { desc = "Format this buffer" })
map("v", "<leader>f", "<cmd>Format<cr>", { desc = "Format this selection" })

-- mappings for note-taking using Obsidian
map("n", "<leader>no", "<cmd>Obsidian<cr>", { desc = "Open Obsidian" })
map("n", "<leader>nt", "<cmd>Obsidian tags<cr>", { desc = "Search Obsidian Tags" })
map("n", "<leader>ns", "<cmd>Obsidian search<cr>", { desc = "Search Obsidian Contents" })
