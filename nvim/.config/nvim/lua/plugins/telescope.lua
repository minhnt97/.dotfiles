return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope_builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", function()
                telescope_builtin.find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end, {})
            -- mappings for search-related actions
            vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
            vim.keymap.set("n", "<leader>fw", telescope_builtin.grep_string, {})
            vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, {})
            vim.keymap.set("n", "<leader>fr", telescope_builtin.registers, {})

            -- mappings LSP actions
            vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<leader>gr", telescope_builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>ge", telescope_builtin.diagnostics, {})

            -- mappings git actions
            vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, {})
            vim.keymap.set("n", "<leader>gc", telescope_builtin.git_commits, {})
            vim.keymap.set("n", "<leader>gb", telescope_builtin.git_bcommits, {})

            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--no-ignore-vcs",
                    },
                },
            })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
