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
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
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
    {
        "sindrets/diffview.nvim",
        config = function()
            vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>")
            vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
        end,
    },
}
