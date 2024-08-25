return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			--- @diagnostic disable-next-line: missing-fields
			configs.setup({
				ensure_installed = {
					"lua",
					"json",
					"css",
					"html",
					"vue",
					"typescript",
					"toml",
					"gdscript",
					"python",
					"hcl",
					"elixir",
					"comment",
					"rust",
					"scss",
					"markdown",
					"markdown_inline",
					"regex",
				},
				auto_install = false,
				sync_install = false,
				incremental_selection = { enable = true },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
