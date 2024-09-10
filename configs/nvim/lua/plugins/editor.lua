local keymap = vim.keymap

return {
	-- {
	-- 	"ggandor/lightspeed.nvim",
	-- 	config = function(_, _)
	-- 		local opts = { noremap = true, silent = true }
	-- 		keymap.set("n", "<leader>s", "<Plug>Lightspeed_s", opts)
	-- 		keymap.set("n", "<leader>S", "<Plug>Lightspeed_S", opts)
	-- 		keymap.set("v", "<leader>s", "<Plug>Lightspeed_s", opts)
	-- 		keymap.set("v", "<leader>S", "<Plug>Lightspeed_S", opts)
	--
	-- 		vim.cmd("silent! unmap s")
	-- 		vim.cmd("silent! unmap S")
	--
	-- 		vim.api.nvim_set_hl(
	-- 			0,
	-- 			"LightspeedCursor",
	-- 			{ bg = "#af0f0f", fg = "#f0f0ff", bold = true, underline = true }
	-- 		)
	-- 	end,
	-- },

	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set("n", "<leader>s", "<Plug>(leap)")
			vim.keymap.set("n", "<leader>S", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "<leader>s", "<Plug>(leap-forward)")
			vim.keymap.set({ "x", "o" }, "<leader>S", "<Plug>(leap-backward)")

            vim.keymap.set({'n', 'x', 'o'}, 'ga',  function ()
                require('leap.treesitter').select()
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
            max_count = 5;
        }
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
        },
    }
}
