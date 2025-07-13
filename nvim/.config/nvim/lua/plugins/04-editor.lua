return {
        {
                -- edit surrounding symbols
                "kylechui/nvim-surround",
                version = "*",
                event = "VeryLazy",
                opts = {},
        },
        {
                -- manual sane window resize & move between panes
                "mrjones2014/smart-splits.nvim",
                lazy = false,
                priority = 1000,
                opts = {},
        },
        {
                -- auto resize windows with animation
                "anuvyklack/windows.nvim",
                dependencies = {
                        "anuvyklack/middleclass",
                        "anuvyklack/animation.nvim",
                },
                config = function()
                        vim.o.winwidth = 5
                        vim.o.winminwidth = 5
                        vim.o.equalalways = false
                        require("windows").setup()
                end,
        },
        {
                -- undo tree
                "mbbill/undotree",
                config = function()
                        vim.g.undotree_WindowLayout = 2
                        vim.g.undotree_SetFocusWhenToggle = 1
                end,
        },
        {
                -- auto remove search highlights
                "nvimdev/hlsearch.nvim",
                event = "BufRead",
                config = true,
        },
        {
                -- for better workflow
                "m4xshen/hardtime.nvim",
                dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
                config = true,
        },
        {
                -- commenting codes
                "numToStr/Comment.nvim",
                config = true,
        },
        {
                -- disable plugins in big files
                "LunarVim/bigfile.nvim",
                opts = {},
        },
        {
                "Furkanzmc/zettelkasten.nvim",
                opts = {},
        },
        {
                "OXY2DEV/markview.nvim",
                lazy = false,
                priority = 100,
                opts = {
                        experimental = {
                                check_rtp_message = false,
                        },
                }
        },
        {
                "toppair/peek.nvim",
                event = { "VeryLazy" },
                build = "deno task --quiet build:fast",
                config = function()
                        require("peek").setup({
                                app = 'browser',
                                theme = 'light',
                        })
                        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
                        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
                end,
        },
        {
                "utilyre/barbecue.nvim",
                name = "barbecue",
                version = "*",
                dependencies = {
                        "SmiteshP/nvim-navic",
                        "nvim-tree/nvim-web-devicons", -- optional dependency
                },
                config = function()
                        -- triggers CursorHold event faster
                        vim.opt.updatetime = 200

                        require("barbecue").setup({
                                create_autocmd = false, -- prevent barbecue from updating itself automatically
                        })

                        vim.api.nvim_create_autocmd({
                                "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
                                "BufWinEnter",
                                "CursorHold",
                                "InsertLeave",

                                -- include this if you have set `show_modified` to `true`
                                "BufModifiedSet",
                        }, {
                                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                                callback = function()
                                        require("barbecue.ui").update()
                                end,
                        })
                end,
        },
        {
                'SCJangra/table-nvim',
                ft = 'markdown',
                opts = {
                        padd_column_separators = true,              -- Insert a space around column separators.
                        mappings = {                                -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
                                next = '<TAB>',                     -- Go to next cell.
                                prev = '<S-TAB>',                   -- Go to previous cell.
                                insert_row_up = '<leader>tk',       -- Insert a row above the current row.
                                insert_row_down = '<leader>tj',     -- Insert a row below the current row.
                                move_row_up = '<leader>tK',         -- Move the current row up.
                                move_row_down = '<leader>tJ',       -- Move the current row down.
                                insert_column_left = '<leader>th',  -- Insert a column to the left of current column.
                                insert_column_right = '<leader>tl', -- Insert a column to the right of current column.
                                move_column_left = '<leader>tH',    -- Move the current column to the left.
                                move_column_right = '<leader>tL',   -- Move the current column to the right.
                                insert_table = '<leader>tt',        -- Insert a new table.
                                insert_table_alt = '<leader>tT',    -- Insert a new table that is not surrounded by pipes.
                                delete_column = '<leader>td',       -- Delete the column under cursor.
                        }
                },
        }
}
