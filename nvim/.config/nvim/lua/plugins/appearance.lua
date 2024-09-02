return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({})
            vim.cmd("colorscheme kanagawa-wave")
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
