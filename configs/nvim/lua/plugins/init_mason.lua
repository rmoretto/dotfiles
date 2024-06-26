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
		"eslint",
		"gopls",
		"html",
		"jsonls",
		"marksman",
		"pyright",
		"rust_analyzer",
		"sqlls",
		"lua_ls",
		"tailwindcss",
		"terraformls",
		"tsserver",
		"volar",
    "rnix",
    "unocss"
	},
})
