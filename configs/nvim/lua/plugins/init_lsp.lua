local lspconfig = require("lspconfig")
local cmp = require("cmp_nvim_lsp")
local illuminate = require("illuminate")

local function base_capabilities()
	return cmp.default_capabilities()
end

local function base_on_attach()
	return function(c)
		illuminate.on_attach(c)
	end
end

local function setup_lsp_config(lsp_name, opts)
	if opts == nil then
		opts = {}
	end

	local capabilities = opts.capabilities or base_capabilities()
	opts.capabilities = capabilities

	local on_attach = opts.on_attach or base_on_attach()
	opts.on_attach = on_attach

	lspconfig[lsp_name].setup(opts)
end

setup_lsp_config("ansiblels")
setup_lsp_config("awk_ls")
setup_lsp_config("bashls")
setup_lsp_config("clangd")
setup_lsp_config("cssls", {
	single_file_support = false,
	settings = {
		css = { validate = true },
		scss = { validate = false },
		less = { validate = true },
	},
})
-- setup_lsp_config("denols")
setup_lsp_config("dockerls")
setup_lsp_config("efm", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"elixir",
	},
})
setup_lsp_config("elixirls", { cmd = { "/home/rodrigo/.local/bin/language_server.sh" } })
setup_lsp_config("erlangls")
setup_lsp_config("eslint")
setup_lsp_config("gopls")
setup_lsp_config("html")
setup_lsp_config("jsonls")
setup_lsp_config("marksman")
setup_lsp_config("pyright")
setup_lsp_config("rust_analyzer")
setup_lsp_config("sqls")
setup_lsp_config("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
					"awesome",
				},
			},
		},
	},
})
setup_lsp_config("tailwindcss")
setup_lsp_config("terraformls")
setup_lsp_config("tsserver", { flags = { debounce_text_changes = 50 } })
setup_lsp_config("volar")

-- Override global border configration for the lsp floating window
local global_border = "rounded"
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or global_border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local function show_diagnostic()
	vim.diagnostic.open_float(0, { scope = "line" })
end

vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
keymap.set("n", "gr", vim.lsp.buf.references, opts)
keymap.set("n", "K", vim.lsp.buf.hover, opts)
keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap.set("n", "<leader>e", show_diagnostic, opts)
keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
