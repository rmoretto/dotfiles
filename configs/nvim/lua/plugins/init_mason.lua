require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"ansiblels",
		"awk_ls",
		"bashls",
		"clangd",
		"cssls",
		"denols",
		"dockerls",
		"efm",
		"elixirls",
		"erlangls",
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"marksman",
		"pyright",
		"rust_analyzer",
		"sqls",
		"sumneko_lua",
		"tailwindcss",
		"terraformls",
		"tsserver",
		"volar",
	},
})
