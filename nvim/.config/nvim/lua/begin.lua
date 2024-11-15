-- Indentation
vim.cmd("set expandtab")
vim.cmd("set tabstop=8")
vim.cmd("set softtabstop=8")
vim.cmd("set shiftwidth=8")

-- Show line number
vim.cmd("set number relativenumber")

-- Ignore case
vim.cmd("set ignorecase")

-- Assign mapleader key
vim.g.mapleader = " "

-- Navigate vim panes
vim.keymap.set("n", "<c-h>", ":NvimTmuxNavigateLeft<CR>")
vim.keymap.set("n", "<c-j>", ":NvimTmuxNavigateDown<CR>")
vim.keymap.set("n", "<c-k>", ":NvimTmuxNavigateUp<CR>")
vim.keymap.set("n", "<c-l>", ":NvimTmuxNavigateRight<CR>")

-- Show cursor line
vim.o.cursorline = true

-- No adding end of file
vim.cmd("set nofixendofline")
