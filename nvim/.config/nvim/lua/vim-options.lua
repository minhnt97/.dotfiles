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

-- Navigate vim panes
vim.keymap.set("n", "<c-h>", ":NvimTmuxNavigateLeft<CR>")
vim.keymap.set("n", "<c-j>", ":NvimTmuxNavigateDown<CR>")
vim.keymap.set("n", "<c-k>", ":NvimTmuxNavigateUp<CR>")
vim.keymap.set("n", "<c-l>", ":NvimTmuxNavigateRight<CR>")

-- Set truecolor
vim.o.termguicolors = true
