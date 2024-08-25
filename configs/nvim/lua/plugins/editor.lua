local keymap = vim.keymap

return {
	{
		"ggandor/lightspeed.nvim",
		config = function(_, _)
			local opts = { noremap = true, silent = true }
			keymap.set("n", "<leader>s", "<Plug>Lightspeed_s", opts)
			keymap.set("n", "<leader>S", "<Plug>Lightspeed_S", opts)
			keymap.set("v", "<leader>s", "<Plug>Lightspeed_s", opts)
			keymap.set("v", "<leader>S", "<Plug>Lightspeed_S", opts)

			vim.cmd("silent! unmap s")
			vim.cmd("silent! unmap S")

			vim.api.nvim_set_hl(
				0,
				"LightspeedCursor",
				{ bg = "#af0f0f", fg = "#f0f0ff", bold = true, underline = true }
			)
		end,
	},

	{ "psliwka/vim-smoothie" },

	{ "tpope/vim-repeat" },
}
