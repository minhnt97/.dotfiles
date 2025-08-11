-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		-- TODO: add location list
		"help",
		"checkhealth",
		"man",
		"notify",
		"qf",
		"LspInfo",
		"DiffView",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- automatically open trouble quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})
