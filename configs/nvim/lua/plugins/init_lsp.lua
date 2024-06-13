local lspconfig = require("lspconfig")
local cmp = require("cmp_nvim_lsp")
local illuminate = require("illuminate")
local utils = require("utils")
local mason_path = require("mason-core.path")
local lsp_location = require("lsp_location")

local function base_capabilities()
  local cmp_capabilities = cmp.default_capabilities()
	return utils.table_merge(cmp_capabilities, additional_capabilities)
end

local function base_on_attach()
	return function(c)
		illuminate.on_attach(c)
	end
end

local function base_cmd(lsp_default_config)
  local bin_path = lsp_default_config.cmd[1]
  return { mason_path.bin_prefix() .. "/" .. bin_path }

end


local function setup_lsp_config(lsp_name, opts)
	if opts == nil then
		opts = {}
	end

  opts.capabilities = utils.table_merge(opts.capabilities or {}, base_capabilities())

	local on_attach = opts.on_attach or base_on_attach()
	opts.on_attach = on_attach

  if lsp_location[lsp_name] then
    opts.cmd = lsp_location[lsp_name]
  end

	lspconfig[lsp_name].setup(opts)
end

require("neodev").setup()

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
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      elixir = {
        {
          lintCommand = [[mix credo suggest --format=flycheck ${INPUT} | sed -e 's/\ D:\ /\ n:\ /g' -e 's/\ R:\ /\ i:\ /g' -e 's/\ C:\ /\ i:\ /g' -e 's/\ F:\ /\ w:\ /g']],
          lintStdin = false,
          lintFormats = { "%f:%l:%c: %t: %m", "%f:%l: %t: %m" },
          rootMarkers = { "mix.lock", "mix.exs" }
        }
      },
    }
  },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"elixir",
	},
})
setup_lsp_config("elixirls", { cmd = { mason_path.bin_prefix() .. "/elixir-ls" } })
setup_lsp_config("erlangls")
setup_lsp_config("eslint")
setup_lsp_config("gopls")
setup_lsp_config("html")
setup_lsp_config("jsonls")
setup_lsp_config("marksman")
setup_lsp_config("pyright")
setup_lsp_config("rust_analyzer")
setup_lsp_config("sqlls")
setup_lsp_config("lua_ls")
setup_lsp_config("tailwindcss")
setup_lsp_config("terraformls")
setup_lsp_config("tsserver", { flags = { debounce_text_changes = 50 } })
setup_lsp_config("volar", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true
      }  
    }
  }
})
setup_lsp_config("arduino_language_server")
setup_lsp_config("nil_ls")
setup_lsp_config("unocss")
setup_lsp_config("gdscript")

-- Override global border configration for the lsp floating window
-- local global_border = "rounded"
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- -- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
-- 	opts = opts or {}
-- 	opts.border = opts.border or global_border
-- 	return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end
-- local function show_diagnostic()
-- 	vim.diagnostic.open_float(0, { scope = "line", width = 75 })
-- end

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
-- keymap.set("n", "gr", vim.lsp.buf.references, opts)
-- keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
-- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
-- keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- keymap.set("n", "<leader>e", show_diagnostic, opts)
-- keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
-- keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
-- keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)

keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "gr", "<cmd>Lspsaga finder<cr>", opts)
keymap.set("n", "gi", "<cmd>Lspsaga peek_definition<cr>", opts)
keymap.set("n", "gs", "<cmd>Lspsaga peek_type_definition<cr>", opts)
keymap.set({ "n", "v" }, "<leader>a", "<cmd>Lspsaga code_action<cr>", opts)
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap.set("n", "<leader>e", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)
keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts)

keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
