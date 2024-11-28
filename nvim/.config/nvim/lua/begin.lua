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
vim.keymap.set("n", "<c-h>", ":NvimTmuxNavigateLeft<CR>", { desc = "Navigate to left pane (both Nvim and Tmux)" })
vim.keymap.set("n", "<c-j>", ":NvimTmuxNavigateDown<CR>", { desc = "Navigate to below pane (both Nvim and Tmux)" })
vim.keymap.set("n", "<c-k>", ":NvimTmuxNavigateUp<CR>", { desc = "Navigate to above pane (both Nvim and Tmux)" })
vim.keymap.set("n", "<c-l>", ":NvimTmuxNavigateRight<CR>", { desc = "Navigate to right pane (both Nvim and Tmux)" })

-- exit terminal mode
vim.keymap.set("t", "jk", "<C-\\><C-N>", { desc = "Exit insert mode in terminal" })

-- Show cursor line
vim.o.cursorline = true

-- No adding end of file
vim.cmd("set nofixendofline")
