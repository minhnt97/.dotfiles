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

			-- change mappings during debug (hover)
			local api = vim.api
			local keymap_restore = {}
			dap.listeners.after["event_initialized"]["me"] = function()
				for _, buf in pairs(api.nvim_list_bufs()) do
					local keymaps = api.nvim_buf_get_keymap(buf, "n")
					for _, keymap in pairs(keymaps) do
						if keymap.lhs == "K" then
							table.insert(keymap_restore, keymap)
							api.nvim_buf_del_keymap(buf, "n", "K")
						end
					end
				end
				api.nvim_set_keymap(
					"n",
					"K",
					'<Cmd>lua require("dapui").eval(nil, {enter=true})<CR>',
					{ silent = true }
				)
			end

			dap.listeners.after["event_terminated"]["me"] = function()
				for _, keymap in pairs(keymap_restore) do
					api.nvim_buf_set_keymap(
						keymap.buffer,
						keymap.mode,
						keymap.lhs,
						keymap.rhs,
						{ silent = keymap.silent == 1 }
					)
				end
				keymap_restore = {}
			end

			-- mappings for watch related actions
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
