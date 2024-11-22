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
				dap.continue()
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

			-- setup UI default layouts
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "repl",
								size = 0.5,
							},
							{
								id = "console",
								size = 0.5,
							},
						},
						position = "bottom",
						size = 15,
					},
				},
			})
			require("nvim-dap-virtual-text").setup()
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
