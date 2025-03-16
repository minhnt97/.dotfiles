return {
        {
                "hrsh7th/nvim-cmp",
                dependencies = {
                        "hrsh7th/cmp-buffer",                   -- buffer source for nvim-cmp
                        "hrsh7th/cmp-path",                     -- path source for nvim-cmp
                        "hrsh7th/cmp-cmdline",                  -- path source for nvim-cmp
                        "neovim/nvim-lspconfig",
                        "hrsh7th/cmp-nvim-lsp",                 -- LSP source for nvim-cmp
                        "hrsh7th/cmp-nvim-lsp-document-symbol", -- display signature help for nvim-cmp
                        "hrsh7th/cmp-nvim-lsp-signature-help",  -- display signature help for nvim-cmp
                        "rafamadriz/friendly-snippets",         -- vs-code like snippets
                        "saadparwaiz1/cmp_luasnip",             -- LuaSnip source for nvim-cmp
                        "L3MON4D3/LuaSnip",                     -- snippet engine
                        "onsails/lspkind.nvim",                 -- add vscode-like icon to completion menu
                        "rcarriga/cmp-dap",                     -- for dap autocompletion
                },
                config = function()
                        -- luasnip setup
                        local luasnip = require("luasnip")

                        -- lspkind setup
                        local lspkind = require("lspkind")

                        -- nvim-cmp setup
                        local cmp = require("cmp")

                        cmp.setup({
                                snippet = {
                                        expand = function(args)
                                                luasnip.lsp_expand(args.body) -- For 'luasnip' users
                                                -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                                        end,
                                },
                                view = {
                                        entries = "custom",
                                        selection_order = "near_cursor",
                                },
                                window = {
                                        completion = cmp.config.window.bordered(),
                                        documentation = cmp.config.window.bordered(),
                                },
                                formatting = {
                                        format = lspkind.cmp_format({
                                                mode = "symbol_text",
                                                menu = {
                                                        buffer = "[Buffer]",
                                                        nvim_lsp = "[LSP]",
                                                        luasnip = "[LuaSnip]",
                                                        nvim_lua = "[Lua]",
                                                        latex_symbols = "[Latex]",
                                                },
                                        }),
                                },
                                mapping = cmp.mapping.preset.insert({
                                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                                        ["<C-f>"] = cmp.mapping.scroll_docs(4),

                                        ["<C-Space>"] = cmp.mapping.complete(),
                                        ["<C-e>"] = cmp.mapping.abort(),

                                        ["<CR>"] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        if luasnip.expandable() then
                                                                luasnip.expand()
                                                        else
                                                                cmp.confirm({
                                                                        select = true,
                                                                })
                                                        end
                                                else
                                                        fallback()
                                                end
                                        end),

                                        ["<Tab>"] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        cmp.select_next_item()
                                                elseif luasnip.locally_jumpable(1) then
                                                        luasnip.jump(1)
                                                else
                                                        fallback()
                                                end
                                        end, { "i", "s" }),

                                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        cmp.select_prev_item()
                                                elseif luasnip.locally_jumpable(-1) then
                                                        luasnip.jump(-1)
                                                else
                                                        fallback()
                                                end
                                        end, { "i", "s" }),
                                }),
                                sources = cmp.config.sources({
                                        { name = "nvim_lsp" },
                                        { name = "luasnip" },
                                        { name = "nvim_lsp_signature_help" },
                                        { name = "path" },
                                        { name = "render-markdown" },
                                }, {
                                        { name = "buffer" },
                                }),

                                -- enable cmp-dap
                                enabled = function()
                                        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or
                                            require("cmp_dap").is_dap_buffer()
                                end,
                        })

                        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                        cmp.setup.cmdline({ "/", "?" }, {
                                mapping = cmp.mapping.preset.cmdline(),
                                sources = cmp.config.sources({
                                        { name = "nvim_lsp_document_symbol" },
                                }, {
                                        { name = "buffer" },
                                }),
                        })

                        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                        cmp.setup.cmdline(":", {
                                mapping = cmp.mapping.preset.cmdline(),
                                sources = cmp.config.sources({
                                        { name = "path" },
                                }, {
                                        { name = "cmdline" },
                                }),
                                matching = { disallow_symbol_nonprefix_matching = false },
                        })

                        -- If you want insert `(` after select function or method item
                        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

                        -- enable cmp-dap
                        require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                                sources = {
                                        { name = "dap" },
                                },
                        })
                end,
        },
        {
                -- for auto insert close pair
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                opts = {},
        },
        {
                "danymat/neogen",
                config = true,
                -- Uncomment next line if you want to follow only stable versions
                -- version = "*"
        },
}
