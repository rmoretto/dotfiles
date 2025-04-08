return {
    -- go fast
	{
		"ggandor/leap.nvim",
		opts = {
            highlight_unlabeled_phase_one_targets = true,
			substitute_chars = {
				[" "] = "␣",
				["\r"] = "¬",
			},
		},
		config = function()
			vim.keymap.set("n", "<leader>s", "<Plug>(leap)")
			vim.keymap.set("n", "<leader>S", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "<leader>s", "<Plug>(leap-forward)")
			vim.keymap.set({ "x", "o" }, "<leader>S", "<Plug>(leap-backward)")

			vim.keymap.set({ "n", "x", "o" }, "ga", function()
				require("leap.treesitter").select()
			end)
		end,
	},

    -- restore the f/F/t/T lightspeed behaviour with leap.nvim
    {
		"ggandor/flit.nvim",
		config = function()
			require("flit").setup()
		end,
	},

    -- Smoothersons scroll
	{ "psliwka/vim-smoothie" },

    -- all hail tpope
	{ "tpope/vim-repeat" },

    -- fix some colors
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				mode = "virtualtext",
			},
		},
	},

    -- code screenshots
	{
		"mistricky/codesnap.nvim",
		build = "make",
		keys = {
			{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
			{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
		},
		opts = {
			save_path = "~/Pictures",
			has_breadcrumbs = true,
			bg_theme = "bamboo",
			bg_padding = 0,
		},
	},

    -- add live commands like :Norm
	{
		"smjonas/live-command.nvim",
		-- live-command supports semantic versioning via Git tags
		-- tag = "2.*",
		config = function()
			require("live-command").setup({
				commands = {
					Norm = { cmd = "norm" },
				},
			})
		end,
	},

    -- kill old unused buffers
    {
		"chrisgrieser/nvim-early-retirement",
		opts = {
			notificationOnAutoClose = true,
			deleteBufferWhenFileDeleted = true,
		},
		event = "VeryLazy",
	},
}
