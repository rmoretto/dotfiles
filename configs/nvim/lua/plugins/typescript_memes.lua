return {
	-- typescript me salva
	{
		"dmmulroy/tsc.nvim",
		opts = {
			bin_path = "vue-tsc",
		},
		config = function(_, opts)
			require("tsc").setup(opts)
		end,
	},

    -- got to auto-imported component 
    { "catgoose/vue-goto-definition.nvim" },

    -- automatically close tags in vue/html files
	{
		"windwp/nvim-ts-autotag",
		config = function(_, _)
			require("nvim-ts-autotag").setup()
		end,
	},

    -- fix shitty comments in .vue file
    {
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			local native_get_option = vim.filetype.get_option
			---@diagnostic disable-next-line: duplicate-set-field
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or native_get_option(filetype, option)
			end
		end,
	},
}
