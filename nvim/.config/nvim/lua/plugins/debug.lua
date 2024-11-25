return {
	{
		-- DAP client
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- mappings for debug session control
			vim.keymap.set("n", "<Leader>dc", function()
				if vim.fn.filereadable(".vscode/launch.json") then
					require("dap.ext.vscode").load_launchjs()
				end
				require("dap").continue()
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				dap.restart()
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
				dapui.float_element("repl", {
					enter = true,
					position = "center",
				})
			end)

			vim.keymap.set("n", "<Leader>dT", function()
				dapui.float_element("console", {
					enter = true,
					position = "center",
				})
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
			vim.keymap.set("n", "<Leader>k", function()
				dapui.eval(nil, { enter = true })
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				dapui.float_element("scopes", {
					enter = true,
				})
			end)
			vim.keymap.set("n", "<Leader>df", function()
				dapui.float_element("stacks", {
					enter = true,
				})
			end)
			vim.keymap.set("n", "<Leader>dw", function()
				dapui.float_element("watches", {
					enter = true,
				})
			end)
			vim.keymap.set("n", "<Leader>dh", "<cmd>DapVirtualTextToggle<CR>")

			-- mappings for UI
			vim.keymap.set("n", "<Leader>du", function()
				dapui.toggle()
			end)

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
						position = "left",
						size = 40,
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
						size = 15,
					},
				},
			})
			require("nvim-dap-virtual-text").setup()

			-- setup debug adapters
			require("dap").adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = os.getenv("HOME")
					.. "/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}
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
