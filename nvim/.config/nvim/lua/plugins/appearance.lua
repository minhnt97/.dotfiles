return {
        {
                "tomasiser/vim-code-dark",
                config = function()
                        vim.cmd.colorscheme("codedark")
                end,
        },
        {
                -- change status line display
                "nvim-lualine/lualine.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                config = function()
                        require("lualine").setup({
                                options = {
                                        theme = "auto",
                                },
                                sections = {
                                        lualine_a = { "mode" },
                                        lualine_b = { "branch", "diff" },
                                        lualine_c = {
                                                {
                                                        "filename",
                                                        path = 1, -- 1: Relative path
                                                },
                                        },

                                        lualine_x = { "encoding", "fileformat", "filetype" },
                                        lualine_y = { "progress" },

                                        lualine_z = { "location" },
                                },
                        })
                end,
        },
        {
                -- change cursor line & number display
                "mawkler/modicator.nvim",
                opts = {
                        -- Warn if any required option above is missing. May emit false positives
                        -- if some other plugin modifies them, which in that case you can just
                        -- ignore. Feel free to remove this line after you've gotten Modicator to
                        -- work properly.
                        show_warnings = true,
                },
        },
        {
                -- display dashboard when nvim starts
                "nvimdev/dashboard-nvim",
                event = "VimEnter",
                config = function()
                        require("dashboard").setup({
                                -- config
                        })
                end,
                dependencies = { { "nvim-tree/nvim-web-devicons" } },
        },
}
