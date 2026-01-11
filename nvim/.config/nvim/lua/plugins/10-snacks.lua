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
			layout = {
				cycle = true,
				--- Use the default layout or vertical if the window is too narrow
				preset = function()
					return vim.o.columns >= 160 and "default" or "vertical"
				end,
			},
			matcher = {
				frecency = true,
				history_bonus = true,
			},
			win = {
				input = {
					keys = {
						["<c-x>"] = { "edit_split", mode = { "i", "n" } },
					},
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		words = { enabled = true },
		notifier = {
			enabled = true,
		},
		statuscolumn = {
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = true, -- show open fold icons
				git_hl = true, -- use Git Signs hl for fold icons
			},
			git = {
				-- patterns to match Git signs
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 50, -- refresh at most every 50ms
		},
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
