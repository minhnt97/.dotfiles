local map = function(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.noremap = true
        opts.silent = true
        vim.keymap.set(mode, lhs, rhs, opts)
end

-- mappings for moving between splits
map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)

-- mappings for manual window resize
map("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize window left" })
map("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize window down" })
map("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize window up" })
map("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize window right" })

-- mappings for swapping buffers between windows
map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

-- mappings for auto window size toggle
map("n", "<C-w>z", "<cmd>WindowsMaximize<cr>", { desc = "Resize window right" })
map("n", "<C-w>=", "<cmd>WindowsEqualize<cr>", { desc = "Resize window right" })

-- mappings for terminal mode
map("t", "jk", "<C-\\><C-N>", { desc = "Exit insert mode in terminal" })

-- mappings for terminal mode
map({ 'n', 'v' }, '<leader>st', require('stay-centered').toggle, { desc = "Toggle stay centered" })

-- mappings for telescope
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

-- mappings for file search
map("n", "<leader>ff", telescope_builtin.find_files, { desc = "(Telescope) Find files" })
map("n", "<leader>FF", function()
        telescope_builtin.find_files({
                hidden = true,
                no_ignore = true,
        })
end, { desc = "(Telescope) Find hidden and ignored files" })
map("n", "<leader>fe", function()
        telescope.extensions.file_browser.file_browser()
end, { desc = "(Telescope) File browser" })
map("n", "<leader>fb", telescope_builtin.buffers, { desc = "(Telescope) Find opening buffers" })
map("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "(Telescope) Find recently opened buffers" })

-- mappings for text search
map("n", "<leader>fg", function()
        telescope.extensions.live_grep_args.live_grep_args({})
end, { desc = "(Telescope) Input and find word" })

map("n", "<leader>fw", function()
        live_grep_args_shortcuts.grep_word_under_cursor({
                postfix = " --iglob *",
                qoute = false,
        })
end, { desc = "(Telescope) Find word under cursor" })

-- mappings for grepping word under cursor in visual mode
map("v", "<space>g", function()
        live_grep_args_shortcuts.grep_visual_selection({
                postfix = " --iglob *",
                qoute = false,
        })
end, { desc = "(Telescope) Find word under visual mode" })

-- mappings for vim
map("n", "<leader>fr", telescope_builtin.registers, { desc = "(Telescope) See vim registers" })
map("n", "<leader>fm", telescope_builtin.keymaps, { desc = "(Telescope) Find keymaps" })

-- mappings for symbols search using LSP
map(
        "n",
        "<leader>fs",
        telescope_builtin.lsp_document_symbols,
        { desc = "(Telescope) Find current buffer's LSP symbols" }
)
map(
        "n",
        "<leader>fa",
        telescope_builtin.lsp_dynamic_workspace_symbols,
        { desc = "(Telescope) Find current project's LSP symbols" }
)
-- mappings for LSP display
map("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "(LSP) Toggle inlay hint display" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "(LSP) Display signature help" })

-- mappings for code actions
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "(LSP) Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "(LSP) Code actions" })

-- mappings for diagnostics
map("n", "<leader>ee", "<cmd>Trouble diagnostics toggle toggle focus=true<CR>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>EE", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "(LSP) Go to next diagnostic position" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "(LSP) Go to prev diagnostic position" })

-- mappings for code navigations
local hover = {
        mapping = "K",
        func = vim.lsp.buf.hover,
        opts = { desc = "(LSP) Hover" },
}
map("n", hover.mapping, hover.func, hover.opts)
map("n", "gd", "<cmd>Trouble lsp_definitions open focus=true<CR>", { desc = "(LSP) Go to definitions" })
map("n", "gD", "<cmd>Trouble lsp_declarations open focus=true<CR>", { desc = "(LSP) Go to declaration" })
map("n", "<leader>gr", "<cmd>Trouble lsp_references open focus=true<CR>", { desc = "(LSP) Go to references" })
map("n", "gi", "<cmd>Trouble lsp_implementations open focus=true<CR>", { desc = "(LSP) Go to implementations" })
map(
        "n",
        "<leader>gt",
        "<cmd>Trouble lsp_type_definitions toggle focus=true<CR>",
        { desc = "(LSP) Go to type_definitions" }
)

-- generate doxygen
map("n", "<leader>nf", require("neogen").generate, { desc = "Generate doxygen" })

-- mappings for debug session control
local dap = require("dap")
local dapui = require("dapui")
map("n", "<Leader>dc", function()
        if vim.fn.filereadable(".vscode/launch.json") then
                require("dap.ext.vscode").load_launchjs()
        end
        dap.continue()
end, { desc = "(Debug) Continue/terminate session" })
map("n", "<Leader>dr", function()
        dap.restart()
end, { desc = "(Debug) Restart session" })
map("n", "<Leader>dx", function()
        dap.terminate()
end, { desc = "(Debug) Terminate session" })

-- mappings for debug actions
map("n", "<Leader>di", function()
        dap.step_into()
end, { desc = "(Debug) Step into function" })
map("n", "<Leader>do", function()
        dap.step_out()
end, { desc = "(Debug) Step out of function" })
map("n", "<Leader>dv", function()
        dap.step_over()
end, { desc = "(Debug) Step over one line of codes" })

-- mappings for console
map("n", "<Leader>dt", function()
        dapui.float_element("repl", {
                enter = true,
                position = "center",
        })
end, { desc = "(Debug) Open debug terminal (repl)" })

map("n", "<Leader>dT", function()
        dapui.float_element("console", {
                enter = true,
                position = "center",
        })
end, { desc = "(Debug) Open debug console" })

-- mappings for breakpoint control
map("n", "<Leader>bt", function()
        dap.toggle_breakpoint()
end, { desc = "(Debug) Toggle breakpoint" })
map("n", "<Leader>bl", function()
        dap.list_breakpoints()
        vim.cmd.copen()
end, { desc = "(Debug) List breakpoints" })
map("n", "<Leader>bx", function()
        dap.clear_breakpoints()
end, { desc = "(Debug) Clear all breakpoints" })

-- mappings for watch related actions
map("n", "<Leader>ds", function()
        dapui.float_element("scopes", {
                enter = true,
        })
end, { desc = "(Debug) Open scopes" })
map("n", "<Leader>df", function()
        dapui.float_element("stacks", {
                enter = true,
        })
end, { desc = "(Debug) Open call stacks" })
map("n", "<Leader>dw", function()
        dapui.float_element("watches", {
                enter = true,
        })
end, { desc = "(Debug) Open watches" })

map("n", "<Leader>dh", "<cmd>DapVirtualTextToggle<CR>", { desc = "(Debug) Toggle virtual text" })
-- use K for both LSP and DAP hover
dap.listeners.after.attach.config_hover_key = function()
        map("n", "K", function()
                dapui.eval(nil, { enter = true })
        end, { desc = "(Debug) Hover" })
end
dap.listeners.before.event_terminated.recover_lsp_keys = function()
        map("n", hover.mapping, hover.func, hover.opts)
end
dap.listeners.before.event_exited.recover_lsp_keys = function()
        map("n", hover.mapping, hover.func, hover.opts)
end

-- mappings for UI
map("n", "<Leader>du", function()
        dapui.toggle()
end, { desc = "(Debug) Toggle UI" })

-- mappings for undo tree
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Resize window right" })

-- mappings for quickfix
map("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Move to next quickfix position" })
map("n", "<leader>cp", "<cmd>cprevious<CR>", { desc = "Move to previous quickfix position" })

-- mappings for location list
map("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
map("n", "<leader>ln", "<cmd>lnext<CR>", { desc = "Move to next location list" })
map("n", "<leader>lp", "<cmd>lprevious<CR>", { desc = "Move to previous location list" })

-- mappings for markdown preview
map("n", "<leader>p", require('render-markdown').toggle, { desc = "Toggle local markdown preview" })
map("n", "<leader>P", function()
        local peek = require("peek")
        if peek.is_open()
        then
                peek.close()
        else
                peek.open()
        end
end, { desc = "Toggle web markdown preview" })

-- mappings for file tree toggle
map("n", "<leader>ef", ":Neotree toggle float reveal_force_cwd<cr>", { desc = "Toggle file-tree in float window" })
map("n", "<leader>el", ":Neotree toggle left reveal_force_cwd <cr>", { desc = "Toggle file-tree in left-side pane" })

-- mappings for gitsigns
require("gitsigns").setup({
        on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map_gitsign(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        map(mode, l, r, opts)
                end

                -- Navigation
                map_gitsign("n", "]c", function()
                        if vim.wo.diff then
                                vim.cmd.normal({ "]c", bang = true })
                        else
                                gitsigns.nav_hunk("next")
                        end
                end, { desc = "(Gitsigns) Move to next hunk" })

                map_gitsign("n", "[c", function()
                        if vim.wo.diff then
                                vim.cmd.normal({ "[c", bang = true })
                        else
                                gitsigns.nav_hunk("prev")
                        end
                end, { desc = "(Gitsigns) Move to prev hunk" })

                -- Stage/unstage hunk & buffer
                map_gitsign("n", "<leader>hs", gitsigns.stage_hunk, { desc = "(Gitsigns) Stage this hunk" })
                map_gitsign("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "(Gitsigns) Unstage this hunk" })
                map_gitsign("v", "<leader>hs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "(Gitsigns) Stage this hunk" })
                map_gitsign("n", "<leader>hS", gitsigns.stage_buffer, { desc = "(Gitsigns) Stage this buffer" })

                -- Reset hunk & buffer
                map_gitsign("n", "<leader>hr", gitsigns.reset_hunk, { desc = "(Gitsigns) Reset this hunk" })
                map_gitsign("v", "<leader>hr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "(Gitsigns) Reset this hunk" })
                map_gitsign("n", "<leader>hR", gitsigns.reset_buffer, { desc = "(Gitsigns) Restore this buffer" })

                -- Compare hunks , deleted
                map_gitsign("n", "<leader>hp", gitsigns.preview_hunk, { desc = "(Gitsigns) Preview this hunk" })
                map_gitsign("n", "<leader>hd", gitsigns.toggle_deleted,
                        { desc = "(Gitsigns) Toggle deleted sections display" })

                -- Blame
                map_gitsign(
                        "n",
                        "<leader>lb",
                        gitsigns.toggle_current_line_blame,
                        { desc = "(Gitsigns) Toggle current line blame info" }
                )
                map_gitsign("n", "<leader>hb", function()
                        gitsigns.blame_line({ full = true })
                end, { desc = "(Gitsigns) Display current hunk blame" })

                -- Text object
                map_gitsign({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "(Gitsigns) Select hunk" })
        end,
})

-- mappings for neogit
map("n", "<leader>ng", "<cmd>Neogit<cr>", { desc = "Open neogit" })

-- mappings for formatting
map("n", "<leader>gf", "<cmd>Format<cr>", { desc = "Format this buffer" })
map("v", "<leader>f", "<cmd>Format<cr>", { desc = "Format this selection" })

-- mappings for note taking
map("n", "<leader>nn", "<cmd>ZkNew<cr>", { desc = "New note" })
map("n", "<leader>nl", "<cmd>ZkBrowse<cr>", { desc = "List notes" })
