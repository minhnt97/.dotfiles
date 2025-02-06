-- Set truecolor
vim.o.termguicolors = true

-- Set colorscheme
vim.cmd.colorscheme("nordic")

if vim.fn.has("win32") == 1 then -- only windows
        vim.g.undotree_DiffCommand = "~/.dotfiles/nvim/diff.exe"
end
