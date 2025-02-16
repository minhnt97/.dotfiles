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
                'MeanderingProgrammer/render-markdown.nvim',
                -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
                -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
                dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
                ---@module 'render-markdown'
                ---@type render.md.UserConfig
                opts = {},
        },
        {
                "iamcco/markdown-preview.nvim",
                cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
                build = "cd app && yarn install",
                init = function()
                        vim.g.mkdp_filetypes = { "markdown" }
                end,
                ft = { "markdown" },
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
}
