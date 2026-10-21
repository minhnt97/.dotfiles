local opencode_cmd = { "opencode", "--port" }

local function opencode_terminal_opts(enter)
	return {
		interactive = false,
		win = {
			position = "right",
			enter = enter,
		},
	}
end

return {
	{
		"nickjvandyke/opencode.nvim",
		-- Defaults to "main", supporting OpenCode v2.
		-- Uncomment to pull the latest stable release, supporting OpenCode v1.
		version = "*",
		keys = {
			{
				"<leader>ot",
				function()
					require("snacks.terminal").toggle(opencode_cmd, opencode_terminal_opts(true))
				end,
				mode = { "n", "x" },
				desc = "Toggle Opencode",
			},
			{
				"<leader>oa",
				function()
					require("opencode").ask("@this: ")
				end,
				mode = { "n", "x" },
				desc = "Ask this in Opencode",
			},
			{
				"<leader>os",
				function()
					require("opencode").select()
				end,
				mode = { "n", "x" },
				desc = "Select Opencode action",
			},
			{
				"<leader>og",
				function()
					return require("opencode").operator("@this")
				end,
				mode = { "n", "x" },
				expr = true,
				desc = "Send range to Opencode",
			},
			{
				"<leader>ol",
				function()
					return require("opencode").operator("@this") .. "_"
				end,
				mode = "n",
				expr = true,
				desc = "Send line to Opencode",
			},
		},
		config = function()
			vim.g.opencode_opts = {
				server = {
					start = function()
						term = require("snacks.terminal").open(opencode_cmd, opencode_terminal_opts(false))
					end,
				},
			}
		end,
	},
}
