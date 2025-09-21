return {
	{
		"saghen/blink.cmp",

		dependencies = {
			"rafamadriz/friendly-snippets", --snippets
			"xzbdmw/colorful-menu.nvim", --extending label
			"nvim-tree/nvim-web-devicons", --icons
			"onsails/lspkind.nvim", --icons
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<Tab>"] = { "select_next", "fallback_to_mappings" },
				["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
			},

			appearance = { nerd_font_variant = "mono" },

			completion = {
				menu = {
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},

							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				ghost_text = { enabled = true },
				list = { selection = { preselect = false } },
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					cmdline = {
						min_keyword_length = function(ctx)
							-- when typing a command, only show when the keyword is 3 characters or longer
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		-- for auto insert close pair
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"danymat/neogen",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
}
