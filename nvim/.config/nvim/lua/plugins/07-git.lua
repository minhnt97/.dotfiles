return {
	{
		-- working with hunks
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signcolumn = true,
				numhl = true,
				linehl = false,
				word_diff = false,
				current_line_blame = true,
				attach_to_untracked = false,
				sign_priority = 6,
				diff_opts = {
					algorithm = "histogram",
				},
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
					end, { desc = "(Gitsigns) Move to next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "(Gitsigns) Move to prev hunk" })

					-- Stage/unstage hunk & buffer
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "(Gitsigns) Stage this hunk" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "(Gitsigns) Unstage this hunk" })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "(Gitsigns) Stage this hunk" })
					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "(Gitsigns) Stage this buffer" })

					-- Reset hunk & buffer
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "(Gitsigns) Reset this hunk" })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "(Gitsigns) Reset this hunk" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "(Gitsigns) Restore this buffer" })

					-- preview hunks
					map(
						"n",
						"<leader>hp",
						gitsigns.preview_hunk_inline,
						{ desc = "(Gitsigns) Preview this hunk inline" }
					)
					map("n", "<leader>hd", gitsigns.diffthis, { desc = "(Gitsigns) Diff this file" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "(Gitsigns) Select hunk" })

					-- Open list of hunks
					map("n", "<leader>hq", gitsigns.setqflist, { desc = "(Gitsigns) Open list of hunks" })
					map("n", "<leader>hQ", function()
						gitsigns.setqflist("all")
					end, { desc = "(Gitsigns) Open list of all hunks" })
				end,
			})
		end,
	},
	{
		"esmuellert/codediff.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "CodeDiff",
		opts = {
			-- Explorer panel configuration
			explorer = {
				position = "bottom", -- "left" or "bottom"
				height = 10, -- Height when position is "bottom" (lines)
			},
		},
	},
}
