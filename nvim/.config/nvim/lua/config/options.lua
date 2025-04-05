-- Indentation
vim.cmd("set expandtab")
vim.cmd("set tabstop=8")
vim.cmd("set softtabstop=8")
vim.cmd("set shiftwidth=8")
vim.cmd("set autoindent")

-- Virtual edit
vim.cmd("set virtualedit=all")

-- Show line number
vim.cmd("set number relativenumber")

-- Ignore case
vim.cmd("set ignorecase")

-- Assign mapleader key
vim.g.mapleader = " "

-- Show cursor line
vim.o.cursorline = true

-- No adding end of file
vim.cmd("set nofixendofline")
