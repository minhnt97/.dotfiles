return {
        {
                "nvim-telescope/telescope.nvim",
                tag = "0.1.8",
                dependencies = { "nvim-lua/plenary.nvim" },
                config = function()
                        local telescope = require("telescope")
                        local telescope_builtin = require("telescope.builtin")

                        -- mappings for file & text search
                        vim.keymap.set("n", "<leader>ff", function()
                                telescope_builtin.find_files({
                                        hidden = true,
                                        no_ignore = true,
                                })
                        end, {})
                        vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
                        vim.keymap.set("n", "<leader>fw", telescope_builtin.grep_string, {})
                        vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, {})
                        vim.keymap.set("n", "<leader>fr", telescope_builtin.registers, {})

                        -- mappings for symbols search using LSP
                        vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, {})
                        vim.keymap.set("n", "<leader>fa", telescope_builtin.lsp_dynamic_workspace_symbols, {})

                        -- connect with trouble
                        local actions = require("telescope.actions")
                        local open_with_trouble = require("trouble.sources.telescope").open
                        -- Use this to add more results without clearing the trouble list
                        local add_to_trouble = require("trouble.sources.telescope").add

                        telescope.setup({
                                defaults = {
                                        sorting_strategy = "ascending",
                                        layout_strategy = "vertical",
                                        layout_config = {
                                                vertical = {
                                                        prompt_position = "top",
                                                },
                                        },
                                        mappings = {
                                                i = { ["<c-t>"] = open_with_trouble },
                                                n = { ["<c-t>"] = open_with_trouble },
                                        },
                                },
                                pickers = {
                                        find_files = {
                                                mappings = {
                                                        n = {
                                                                ["cd"] = function(prompt_bufnr)
                                                                        local selection = require(
                                                                        "telescope.actions.state").get_selected_entry()
                                                                        local dir = vim.fn.fnamemodify(selection.path,
                                                                                ":p:h")
                                                                        require("telescope.actions").close(prompt_bufnr)
                                                                        -- Depending on what you want put `cd`, `lcd`, `tcd`
                                                                        vim.cmd(string.format("silent lcd %s", dir))
                                                                end,
                                                        },
                                                },
                                        },
                                        lsp_document_symbols = {
                                                symbol_width = 50,
                                        },
                                        lsp_dynamic_workspace_symbols = {
                                                fname_width = 50,
                                        },
                                        lsp_references = {
                                                fname_width = 50,
                                                include_current_line = true,
                                                trim_text = true,
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
        {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
                config = function()
                        local telescope = require("telescope")

                        telescope.setup({
                                extensions = {
                                        file_browser = {
                                                theme = "ivy",
                                        },
                                },
                        })

                        vim.keymap.set("n", "<leader>fe", function()
                                require("telescope").extensions.file_browser.file_browser()
                        end, {})

                        telescope.load_extension("file_browser")
                end,
        },
        {
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
                config = function()
                        local telescope = require("telescope")
                        local lga_actions = require("telescope-live-grep-args.actions")

                        telescope.setup({
                                extensions = {
                                        live_grep_args = {
                                                auto_quoting = true, -- enable/disable auto-quoting
                                                -- define mappings, e.g.
                                                mappings = { -- extend mappings
                                                        i = {
                                                                ["<C-k>"] = lga_actions.quote_prompt(),
                                                                ["<C-i>"] = lga_actions.quote_prompt({
                                                                        postfix = " --iglob ",
                                                                }),
                                                                -- freeze the current list and start a fuzzy search in the frozen list
                                                                -- ["<C-space>"] = actions.to_fuzzy_refine,
                                                        },
                                                },
                                                -- ... also accepts theme settings, for example:
                                                -- theme = "dropdown", -- use dropdown theme
                                                -- theme = { }, -- use own theme spec
                                                -- layout_config = { mirror=true }, -- mirror preview pane
                                        },
                                },
                        })

                        vim.keymap.set("n", "<leader>fg", function()
                                telescope.extensions.live_grep_args.live_grep_args()
                        end, {})

                        -- then load the extension
                        telescope.load_extension("live_grep_args")
                end,
        },
}
