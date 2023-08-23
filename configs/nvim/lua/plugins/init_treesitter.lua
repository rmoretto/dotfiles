require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },
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
    "scss"
	},
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
