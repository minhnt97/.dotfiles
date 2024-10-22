return {
        {
                -- DAP client
                "mfussenegger/nvim-dap",
                dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
                config = function()
                        local dap, dapui = require("dap"), require("dapui")

                        -- mappings for debug session control
                        vim.keymap.set("n", "<Leader>dc", function()
                                dap.continue()
                        end)
                        vim.keymap.set("n", "<Leader>dr", function()
                                dap.restart()
                        end)
                        vim.keymap.set("n", "<Leader>dl", function()
                                dap.run_last()
                        end)
                        vim.keymap.set("n", "<Leader>dx", function()
                                dap.terminate()
                        end)

                        -- mappings for debug actions
                        vim.keymap.set("n", "<Leader>di", function()
                                dap.step_into()
                        end)
                        vim.keymap.set("n", "<Leader>do", function()
                                dap.step_out()
                        end)
                        vim.keymap.set("n", "<Leader>dv", function()
                                dap.step_over()
                        end)

                        -- mappings for console
                        vim.keymap.set("n", "<Leader>dt", function()
                                dapui.float_element("repl")
                        end)
                        vim.keymap.set("n", "<Leader>dT", function()
                                dapui.float_element("console")
                        end)

                        -- mappings for UI
                        vim.keymap.set("n", "<Leader>du", function()
                                dapui.toggle()
                        end)

                        -- mappings for breakpoint control
                        vim.keymap.set("n", "<Leader>bt", function()
                                dap.toggle_breakpoint()
                        end)
                        vim.keymap.set("n", "<Leader>bl", function()
                                dap.list_breakpoints()
                                vim.cmd.copen()
                        end)
                        vim.keymap.set("n", "<Leader>bx", function()
                                dap.clear_breakpoints()
                        end)

                        -- mappings for watch related actions
                        vim.keymap.set("n", "<Leader>dk", function()
                                dapui.eval()
                        end)

                        -- auto start UI when debug session starts
                        dap.listeners.before.attach.dapui_config = function()
                                dapui.open()
                        end
                        dap.listeners.before.launch.dapui_config = function()
                                dapui.open()
                        end
                        dap.listeners.before.event_terminated.dapui_config = function()
                                dapui.close()
                        end
                        dap.listeners.before.event_exited.dapui_config = function()
                                dapui.close()
                        end

                        -- setup UI default layouts
                        dapui.setup({
                                layouts = {
                                        {
                                                elements = {
                                                        {
                                                                id = "scopes",
                                                                size = 0.25,
                                                        },
                                                        {
                                                                id = "breakpoints",
                                                                size = 0.25,
                                                        },
                                                        {
                                                                id = "stacks",
                                                                size = 0.25,
                                                        },
                                                        {
                                                                id = "watches",
                                                                size = 0.25,
                                                        },
                                                },
                                                position = "right",
                                                size = 50,
                                        },
                                        {
                                                elements = {
                                                        {
                                                                id = "console",
                                                                size = 0.5,
                                                        },
                                                        {
                                                                id = "repl",
                                                                size = 0.5,
                                                        },
                                                },
                                                position = "bottom",
                                                size = 10,
                                        },
                                },
                        })
                end,
        },
        {
                -- for python
                "mfussenegger/nvim-dap-python",
                config = function()
                        require("dap-python").setup("python")
                end,
        },
}
