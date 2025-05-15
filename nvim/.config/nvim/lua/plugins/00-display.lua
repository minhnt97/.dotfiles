return {
        {
                "thesimonho/kanagawa-paper.nvim",
                lazy = false,
                priority = 1000,
                opts = {},
        },
        {
                "vague2k/vague.nvim",
                lazy = false,
                priority = 1000,
                config = function()
                        -- NOTE: you do not need to call setup if you don't want to.
                        require("vague").setup({
                                -- optional configuration here
                        })
                end
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
                                        lualine_b = { "branch", "selectioncount" },
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
                -- display rainbow delimeters
                "HiPhish/rainbow-delimiters.nvim",
        },
        {
                -- show guideline for indent
                "lukas-reineke/indent-blankline.nvim",
                main = "ibl",
                ---@module "ibl"
                ---@type ibl.config
                config = function()
                        local highlight = {
                                "RainbowRed",
                                "RainbowYellow",
                                "RainbowBlue",
                                "RainbowOrange",
                                "RainbowGreen",
                                "RainbowViolet",
                                "RainbowCyan",
                        }
                        local hooks = require("ibl.hooks")
                        -- create the highlight groups in the highlight setup hook, so they are reset
                        -- every time the colorscheme changes
                        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
                        end)

                        vim.g.rainbow_delimiters = { highlight = highlight }
                        require("ibl").setup({
                                viewport_buffer = {
                                        min = 100,
                                },
                                indent = {
                                        priority = 8,
                                        char = "┊",
                                        smart_indent_cap = true,
                                        repeat_linebreak = false,
                                },
                                scope = {
                                        highlight = highlight,
                                        show_start = false,
                                        show_end = false,
                                        show_exact_scope = false,
                                },
                                exclude = {
                                        filetypes = {
                                                "lspinfo",
                                                "packer",
                                                "checkhealth",
                                                "help",
                                                "man",
                                                "gitcommit",
                                                "TelescopePrompt",
                                                "TelescopeResults",
                                                "dashboard",
                                                "''",
                                        },
                                },
                        })

                        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
                        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
                        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
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
                -- display dashboard when nvim starts
                "nvimdev/dashboard-nvim",
                event = "VimEnter",
                opts = {},
                dependencies = { { "nvim-tree/nvim-web-devicons" } },
        },
}
