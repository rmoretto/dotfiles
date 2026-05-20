return {
	-- go fast
	{
		url = "https://codeberg.org/andyg/leap.nvim",
		opts = {
			-- highlight_unlabeled_phase_one_targets = true,
			substitute_chars = {
				[" "] = "␣",
				["\r"] = "␣",
				["\n\r"] = "␣",
				["\n"] = "␣",
			},
		},
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

			vim.keymap.set({ "n", "x", "o" }, "ga", function()
				require("leap.treesitter").select()
			end)

			-- require('leap.user').set_repeat_keys('<enter>', '<backspace>')
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

	-- help
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},

	{
		"vieitesss/miniharp.nvim",
		version = "*", -- latest stable release
		-- branch = 'main', -- latest nightly version
		opts = {
			autoload = true,
			autosave = true,
			show_on_autoload = false,
			notifications = true,
			ui = {
				position = "bottom-left", -- `top-left`, `top-right`, `bottom-left`, `bottom-right`.
				show_hints = true,
				enter = true, -- Whether to enter the floating window or not
			},
		},
		config = function(_, opts)
			local miniharp = require("miniharp")
			miniharp.setup(opts)

			vim.keymap.set("n", "<leader>m", miniharp.toggle_file, { desc = "miniharp: toggle file mark" })
			vim.keymap.set("n", "<C-n>", miniharp.next, { desc = "miniharp: next file mark" })
			vim.keymap.set("n", "<C-p>", miniharp.prev, { desc = "miniharp: prev file mark" })
			vim.keymap.set("n", "<leader>l", miniharp.show_list, { desc = "miniharp: toggle marks list" })
			vim.keymap.set("n", "<leader>L", miniharp.enter_list, { desc = "miniharp: enter marks list" })

			vim.keymap.set("n", "<leader>1", function() miniharp.go_to(1) end, { desc = "miniharp: go to mark 1" })
			vim.keymap.set("n", "<leader>2", function() miniharp.go_to(2) end, { desc = "miniharp: go to mark 2" })
			vim.keymap.set("n", "<leader>3", function() miniharp.go_to(3) end, { desc = "miniharp: go to mark 3" })
			vim.keymap.set("n", "<leader>4", function() miniharp.go_to(4) end, { desc = "miniharp: go to mark 4" })
		end,
	},
}
