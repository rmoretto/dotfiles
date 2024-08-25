local keymap = vim.keymap

return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = false,
		opts = function()
			local actions = require("telescope.actions")

			return {
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
						},
						n = {
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
						},
					},
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)

            local keyopts = { noremap = true, silent = true }
            keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", keyopts)
            keymap.set("n", "<leader>fp", "<cmd>Telescope live_grep<cr>", keyopts)
            keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", keyopts)
            keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", keyopts)
		end,
	},

	-- Ranger
	-- {
	-- 	"kevinhwang91/rnvimr",
	-- 	config = function(_, _)
	-- 		vim.g.rnvimr_draw_border = 1
	-- 		vim.g.rnvimr_ranger_cmd = { "ranger", '--cmd="set draw_borders both"' }
	-- 		vim.g.rnvimr_enable_picker = 1
	-- 		vim.g.rnvimr_hide_gitignore = 0
	-- 		vim.g.rnvimr_enable_bw = 1
	--
	-- 		local opts = { noremap = true, silent = true }
	-- 		keymap.set("t", "<M-i>", "<C-\\><C-n>:RnvimrResize<CR>", opts)
	-- 		keymap.set("n", "<A-q>", ":RnvimrToggle<CR>", opts)
	-- 		keymap.set("t", "<A-q>", "<C-\\><C-n>:RnvimrToggle<CR>", opts)
	-- 	end,
	-- },

    -- Oil
    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            columns = {
                "permissions",
                "size",
                "mtime",
                "icon",
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)

			local key_opts = { noremap = true, silent = true }
			keymap.set("n", "<A-q>", ":Oil<CR>", key_opts)
        end,
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
}
