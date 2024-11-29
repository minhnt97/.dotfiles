return {
	{
		-- working with hunks
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				attach_to_untracked = true,
				sign_priority = 90,
				signs = {
					delete = { text = "󰍵" },
					changedelete = { text = "󱕖" },
				},
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
					end, { desc = "Move to next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Move to prev hunk" })

					-- Stage/unstage hunk & buffer
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage this hunk" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage this hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage this hunk" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage this buffer" })

					-- Reset hunk & buffer
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset this hunk" })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset this hunk" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Restore this buffer" })

					-- Compare hunks , deleted
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview this hunk" })
					map("n", "<leader>hd", gitsigns.toggle_deleted, { desc = "Toggle deleted sections display" })

					-- Blame
					map(
						"n",
						"<leader>lb",
						gitsigns.toggle_current_line_blame,
						{ desc = "Toggle current line blame info" }
					)
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Display current hunk blame" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
				end,
			})
		end,
	},
	{
		-- view git diff
		"sindrets/diffview.nvim",
		config = function()
			vim.opt.fillchars:append({ diff = "╱" })
			require("diffview").setup({
				enhanced_diff_hl = false,
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
		-- enhanced control of git
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<cr>", { desc = "Open neogit" })
			require("neogit").setup({
				graph_style = "kitty",
			})
		end,
	},
}
