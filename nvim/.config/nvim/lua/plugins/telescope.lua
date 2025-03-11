return {
        {
                "nvim-telescope/telescope.nvim",
                tag = "0.1.8",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        {
                                "nvim-telescope/telescope-fzf-native.nvim",
                                build = "make",
                        },
                        {
                                "nvim-telescope/telescope-live-grep-args.nvim",
                                -- This will not install any breaking changes.
                                -- For major updates, this must be adjusted manually.
                                version = "^1.0.0",
                        },
                        "nvim-telescope/telescope-ui-select.nvim",
                        "nvim-telescope/telescope-file-browser.nvim",
                        "nvim-telescope/telescope-dap.nvim",
                        {
                                "aaronhallaert/advanced-git-search.nvim",
                                cmd = { "AdvancedGitSearch" },
                                dependencies = {
                                        "sindrets/diffview.nvim",
                                },
                        },
                },
                config = function()
                        local telescope = require("telescope")
                        local lga_actions = require("telescope-live-grep-args.actions")
                        local actions = require("telescope.actions")
                        local open_with_trouble = require("trouble.sources.telescope").open
                        local add_to_trouble = require("trouble.sources.telescope").add

                        -- setup everything
                        telescope.setup({
                                defaults = {
                                        prompt_prefix = "   ",
                                        vimgrep_arguments = {
                                                {
                                                        "rg",
                                                        "--color=never",
                                                        "--no-heading",
                                                        "--with-filename",
                                                        "--line-number",
                                                        "--column",
                                                        "--smart-case",
                                                        "--ignore-case"
                                                }
                                        },
                                        mappings = {
                                                i = { ["<c-t>"] = open_with_trouble },
                                                n = { ["<c-t>"] = open_with_trouble },
                                        },
                                        sorting_strategy = "ascending",
                                        path_display = {
                                                truncate = 3,
                                        },
                                        layout_strategy = "flex",
                                        layout_config = {
                                                horizontal = {
                                                        prompt_position = "top",
                                                        width = 0.9,
                                                        preview_width = 0.55,
                                                },
                                                vertical = {
                                                        prompt_position = "top",
                                                        width = 0.9,
                                                },
                                                flex = {
                                                        flip_columns = 200,
                                                },
                                        },
                                        preview = {
                                                timeout = false,
                                        },
                                },
                                pickers = {
                                        find_files = {
                                                mappings = {
                                                        n = {
                                                                ["cd"] = function(prompt_bufnr)
                                                                        local selection = require(
                                                                                    "telescope.actions.state")
                                                                            .get_selected_entry()
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
                                extensions = {
                                        ["ui-select"] = {
                                                require("telescope.themes").get_dropdown({}),
                                        },
                                        file_browser = {},
                                        advanced_git_search = {
                                                diff_plugin = "diffview",
                                        },
                                        live_grep_args = {
                                                auto_quoting = true, -- enable/disable auto-quoting
                                                mappings = {         -- extend mappings
                                                        i = {
                                                                ["<C-h>"] = lga_actions.quote_prompt({
                                                                        postfix = " --hidden --no-ignore ",
                                                                }),
                                                                ["<C-k>"] = lga_actions.quote_prompt({
                                                                        postfix = " --iglob *",
                                                                }),
                                                                -- freeze the current list and start a fuzzy search in the frozen list
                                                                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                                                        },
                                                },
                                        },
                                },
                        })

                        telescope.load_extension("fzf")
                        telescope.load_extension("live_grep_args")
                        telescope.load_extension("ui-select")
                        telescope.load_extension("file_browser")
                        telescope.load_extension("dap")
                        telescope.load_extension("advanced_git_search")
                end,
        },
}
