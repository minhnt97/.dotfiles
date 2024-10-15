return {
        {
                -- edit surrounding symbols
                "kylechui/nvim-surround",
                version = "*",
                event = "VeryLazy",
                config = function()
                        require("nvim-surround").setup({})
                end,
        },
        {
                -- navigate between nvim and tmux
                "alexghergh/nvim-tmux-navigation",
                config = function()
                        require("nvim-tmux-navigation").setup({
                                disable_when_zoomed = true,
                        })
                end,
        },
        {
                -- view undo tree
                "mbbill/undotree",
                config = function()
                        vim.g.undotree_WindowLayout = 2
                        vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
                end,
        },
        {
                -- view git diff
                "sindrets/diffview.nvim",
                config = function()
                        vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>")
                        vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
                end,
        },
        {
                -- auto remove search highlights
                "nvimdev/hlsearch.nvim",
                event = "BufRead",
                config = function()
                        require("hlsearch").setup()
                end,
        },
        {
                -- auto hightlights same word under cursor
                "RRethy/vim-illuminate",
                config = function()
                        require("illuminate").configure({})
                end,
        },
        {
                -- for quickfix preview
                "kevinhwang91/nvim-bqf",
                ft = "qf",
        },
        {
                -- for quickfix line display
                "yorickpeterse/nvim-pqf",
                config = function()
                        require("pqf").setup()
                end,
        },
}
