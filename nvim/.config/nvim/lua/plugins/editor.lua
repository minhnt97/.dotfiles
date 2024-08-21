return {
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            require("nvim-tmux-navigation").setup({
                disable_when_zoomed = true,
            })
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            vim.g.undotree_WindowLayout = 2
            vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
        end,
    },
}
