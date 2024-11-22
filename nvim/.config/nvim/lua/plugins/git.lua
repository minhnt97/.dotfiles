return {
	{
		-- working with hunks
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				attach_to_untracked = true,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Stage/unstage hunk & buffer
					map("n", "<leader>hs", gitsigns.stage_hunk)
					map("n", "<leader>hu", gitsigns.undo_stage_hunk)
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gitsigns.stage_buffer)

					-- Reset hunk & buffer
					map("n", "<leader>hr", gitsigns.reset_hunk)
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hR", gitsigns.reset_buffer)

					-- Compare hunks , deleted
					map("n", "<leader>hp", gitsigns.preview_hunk)
					map("n", "<leader>td", gitsigns.toggle_deleted)

					-- Blame
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	{
		-- view git diff
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>")
			vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					default = {
						-- Config for changed files, and staged files in diff views.
						layout = "diff2_horizontal",
						disable_diagnostics = true,
					},
				},
				file_panel = {
					win_config = { -- See |diffview-config-win_config|
						type = "split",
						position = "bottom",
						height = 15,
						win_opts = {},
					},
				},
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("neogit").setup({
				graph_style = "kitty",
			})
		end,
	},
}
