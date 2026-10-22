local map = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = true
	opts.silent = true
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- mappings for moving between splits
for key, fn in pairs({ h = "move_cursor_left", j = "move_cursor_down", k = "move_cursor_up", l = "move_cursor_right" }) do
	map("t", "<C-" .. key .. ">", function()
		require("smart-splits")[fn]()
	end)
end

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

-- mappings for tab switching
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

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

map("n", "<leader>r", function()
	Snacks.picker.resume()
end, { desc = "Resume Last Picker" })

map("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

map("n", "<leader>/", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })

map("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })

map("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })

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
map("n", "]d", vim.diagnostic.goto_next, { desc = "(LSP) Go to next diagnostic position" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "(LSP) Go to prev diagnostic position" })

-- mappings for code navigations
map("n", "K", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "(LSP & Fold) Hover" })
map("n", "gd", "<cmd>Trouble lsp_definitions open focus=true<CR>", { desc = "(LSP) Go to definitions" })
map("n", "gD", "<cmd>Trouble lsp_declarations open focus=true<CR>", { desc = "(LSP) Go to declaration" })
map("n", "gr", "<cmd>Trouble lsp_references open focus=true<CR>", { desc = "(LSP) Go to references", nowait = true })
map("n", "gI", "<cmd>Trouble lsp_implementations open focus=true<CR>", { desc = "(LSP) Go to implementations" })
map("n", "gY", "<cmd>Trouble lsp_type_definitions toggle focus=true<CR>", { desc = "(LSP) Go to t[y]pe definitions" })
map("n", "gai", "<cmd>Trouble lsp_incoming_calls toggle focus=true<CR>", { desc = "LSP C[a]lls incoming" })
map("n", "gao", "<cmd>Trouble lsp_outgoinq_calls toggle focus=true<CR>", { desc = "LSP C[a]lls outgoing" })

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

-- mappings for formatting
map("n", "<leader>gf", "<cmd>Format<cr>", { desc = "Format this buffer" })
map("v", "<leader>gf", "<cmd>Format<cr>", { desc = "Format this selection" })

-- mappings for folding
map("n", "zO", require("ufo").openAllFolds, { desc = "Open All Folds" })
map("n", "zC", require("ufo").closeAllFolds, { desc = "Close All Folds" })

-- mappings to exit terminal mode
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
