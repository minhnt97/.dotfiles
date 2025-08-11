return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = {
			enabled = true,
			only_scope = true, -- only show indent guides of the scope
			only_current = true, -- only show indent guides in the current window
			chunk = {
				enabled = true,
			},
		},
		picker = {
			enabled = true,
			matcher = {
				frecency = true,
				history_bonus = true,
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		words = { enabled = true },
	},
	keys = {},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command
			end,
		})
	end,
}
