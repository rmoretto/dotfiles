return {
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

	{ "psliwka/vim-smoothie" },
	{ "tpope/vim-repeat" },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				mode = "virtualtext",
			},
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			max_count = 5,
		},
	},

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

	-- {
	-- 	"lewis6991/satellite.nvim",
	-- 	config = function()
	-- 		require("satellite").setup()
	-- 	end,
	-- },
}
