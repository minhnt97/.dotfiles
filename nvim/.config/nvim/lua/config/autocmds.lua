-- automatically open starts treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"cpp",
		"comment",
		"csv",
		"devicetree",
		"diff",
		"doxygen",
		"python",
		"markdown",
		"markdown_inline",
		"gitcommit",
		"git_rebase",
		"gitignore",
		"cmake",
		"make",
		"xml",
		"html",
		"lua",
		"bash",
		"powershell",
		"json",
		"kconfig",
		"latex",
		"ninja",
		"mermaid",
		"objc",
		"objdump",
	},
	callback = function()
		vim.treesitter.start()
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
		vim.wo.foldmethod = "expr"
	end,
})

-- automatically open trouble quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})
