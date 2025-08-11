-- Indentation
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

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
