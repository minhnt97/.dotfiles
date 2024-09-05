return {
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_better_performance = true
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                },
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- 1: Relative path
                        },
                    },
                },
            })
        end,
    },
}
