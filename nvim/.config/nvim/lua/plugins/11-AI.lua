return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			-- suggestions are served through blink.cmp (blink-copilot)
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
}
