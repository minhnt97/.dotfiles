-- automatically open starts treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- automatically open trouble quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})
