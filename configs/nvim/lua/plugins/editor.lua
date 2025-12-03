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

    -- Shine undo/redo
    {
        "y3owk1n/undo-glow.nvim",
        version = "*", -- remove this if you want to use the `main` branch
        opts = {
            animation = {
                enabled = true
            }
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        }
    }

	-- hello AI
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	version = false, -- Never set this value to "*"! Never!
	-- 	opts = {
	-- 		-- add any opts here
	-- 		-- for example
	-- 		provider = "deepseek",
	--            vendors = {
	--                deepseek = {
	--                    __inherited_from = 'openai',
	--                    endpoint = "https://api.deepseek.com",
	--                    model = "deepseek-coder", -- your desired model (or use gpt-4o, etc.)
	--                    api_key_name = "DEEP_SEEK_KEY",
	--                    max_completion_tokens = 8192,
	--                    -- timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
	--                    -- temperature = 0,
	--                    --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
	--                }
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"echasnovski/mini.pick", -- for file_selector provider mini.pick
	-- 		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	-- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
}
