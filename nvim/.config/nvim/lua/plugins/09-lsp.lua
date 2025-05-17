return {
        {
                "neovim/nvim-lspconfig",
                dependencies = {
                        "williamboman/mason-lspconfig.nvim",
                        "williamboman/mason.nvim",
                },
                config = function()
                        local servers = {
                                "lua_ls",
                                "clangd",
                                "lemminx",
                                "cmake",
                                "marksman",
                        }

                        -- install mason
                        require("mason").setup({
                                ui = {
                                        icons = {
                                                package_pending = " ",
                                                package_installed = " ",
                                                package_uninstalled = " ",
                                        },
                                },
                        })

                        -- specific configuration
                        vim.lsp.config['clangd'] = {
                                settings = {
                                        cmd = {
                                                'clangd',
                                                '--all-scopes-completion',
                                                '--background-index',
                                                '--clang-tidy',
                                                '--header-insertion=never',
                                                '--limit-references=0',
                                                '--limit-results=0',
                                                '--rename-file-limit=0',
                                        },
                                        init_options = {
                                                fallbackFlags = { '-std=c++11' },
                                        },
                                }
                        }

                        -- enable server
                        for _, lsp in ipairs(servers) do
                                vim.lsp.enable(lsp)
                        end

                        -- disable diagnostics display to use tiny line
                        vim.diagnostic.config({ virtual_text = false })
                end,
        },
        {
                "folke/trouble.nvim",
                opts = {
                        auto_refresh = false, -- auto refresh when open
                        auto_close = true,    -- auto close when there are no items
                        auto_jump = true,     -- auto jump to the item when there's only one
                        keys = {
                                J = "next",
                                K = "prev",
                        },
                        modes = {
                                lsp_references = {
                                        params = {
                                                include_declaration = false,
                                        },
                                },
                                lsp_base = {
                                        params = {
                                                include_current = true,
                                        },
                                },
                        },
                }, -- for default options, refer to the configuration section for custom setup.
                cmd = "Trouble",
        },
}
