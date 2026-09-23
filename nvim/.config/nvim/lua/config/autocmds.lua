-- automatically open starts treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local ft = args.match
		local lang = vim.treesitter.language.get_lang(ft) or ft
		if not pcall(vim.treesitter.language.add, lang) then
			return
		end
		pcall(vim.treesitter.start, args.buf, lang)
	end,
})

-- automatically open trouble quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})
