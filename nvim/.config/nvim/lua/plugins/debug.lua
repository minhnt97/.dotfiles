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
			vim.keymap.set("n", "<Leader>dh", "<cmd>DapVirtualTextToggle<CR>")

			-- setup UI default layouts
			dapui.setup({})
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
