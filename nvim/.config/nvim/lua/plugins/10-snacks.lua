-- single border style shared by all picker layouts
local border = "rounded"
local title = "{title} {live} {flags}"

-- preview on top, input + results below
local dropdown = {
	layout = {
		backdrop = false,
		row = 1,
		width = 0.9,
		min_width = 80,
		height = 0.9,
		border = "none",
		box = "vertical",
		{ win = "preview", title = "{preview}", height = 0.6, border = border },
		{
			box = "vertical",
			border = border,
			title = title,
			title_pos = "center",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
	},
}

-- results on the left, preview on the right
local wide = {
	layout = {
		box = "horizontal",
		width = 0.9,
		min_width = 120,
		height = 0.8,
		{
			box = "vertical",
			border = border,
			title = title,
			title_pos = "center",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
		{ win = "preview", title = "{preview}", border = border, width = 0.5 },
	},
}

-- file names only, no preview
local vscode = {
	hidden = { "preview" },
	layout = {
		backdrop = false,
		row = 0.2,
		width = 0.6,
		min_width = 80,
		height = 0.4,
		border = "none",
		box = "vertical",
		{
			box = "vertical",
			border = border,
			title = title,
			title_pos = "center",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
		{ win = "preview", title = "{preview}", border = border },
	},
}

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
			formatters = {
				file = {
					filename_first = true, -- display filename before the file path
					---@type "left"|"center"|"right"
					truncate = "left",
					min_width = 20, -- minimum length of the truncated path
				},
			},
			layout = function()
				return vim.o.columns >= 120 and wide or dropdown
			end,
			actions = {
				-- switch the current picker between the wide default and dropdown layouts
				toggle_layout = function(picker)
					local use_dropdown = picker.opts._dropdown_layout
					if use_dropdown == nil then
						use_dropdown = (picker.resolved_layout.layout or {}).box == "vertical"
					end
					use_dropdown = not use_dropdown
					picker.opts._dropdown_layout = use_dropdown
					picker:set_layout(Snacks.picker.config.layout({ layout = use_dropdown and dropdown or wide }))
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
						["<c-t>"] = { "toggle_layout", mode = { "i", "n" } },
					},
				},
			},
			sources = (function()
				local sources = {}
				-- file / command pickers: quick lists without preview
				for _, name in ipairs({
					"files",
					"git_files",
					"git_status",
					"recent",
					"buffers",
					"smart",
					"projects",
					"zoxide",
					"commands",
					"command_history",
					"search_history",
				}) do
					sources[name] = { layout = vscode }
				end
				for _, name in ipairs({
					"grep",
					"grep_word",
					"grep_buffers",
					"lsp_definitions",
					"lsp_declarations",
					"lsp_references",
					"lsp_implementations",
					"lsp_type_definitions",
					"lsp_incoming_calls",
					"lsp_outgoing_calls",
					"lsp_symbols",
					"lsp_workspace_symbols",
					"diagnostics",
				}) do
					sources[name] = { layout = dropdown }
				end
				for _, name in ipairs({
					"lsp_definitions",
					"lsp_declarations",
					"lsp_references",
					"lsp_implementations",
					"lsp_type_definitions",
					"lsp_incoming_calls",
					"lsp_outgoing_calls",
				}) do
					sources[name].include_current = true
				end
				sources.lsp_references.include_declaration = false
				return sources
			end)(),
		},
		input = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		words = { enabled = true },
		notifier = {
			enabled = true,
		},
		statuscolumn = {
			enabled = true,
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
		lazygit = { win = { border = "rounded" } },
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
