return {
        {
                "nvim-treesitter/nvim-treesitter",
                dependencies = {
                        "nvim-treesitter/nvim-treesitter-textobjects",
                },
                build = ":TSUpdate",
                run = ":TSUpdate",
                config = function()
                        require("nvim-treesitter.configs").setup({
                                auto_install = true,
                                highlight = { enable = true },
                                indent = { enable = true },
                        })
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
