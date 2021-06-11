
 -- Elixir Config
require'lspconfig'.elixirls.setup{
    cmd = { "/home/rodrigo/.local/bin/language_server.sh" }
}

-- TypeScript Config
require'lspconfig'.tsserver.setup{}

-- HTML Config
local html_capabilities = vim.lsp.protocol.make_client_capabilities()
html_capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = html_capabilities,
}

-- CSS Config
local css_capabilities = vim.lsp.protocol.make_client_capabilities()
css_capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = css_capabilities,
}

-- Vue Config
require'lspconfig'.vuels.setup{}

-- EFM LS
local eslint = {
    lintCommand = "yarn eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local credo = {
    lintCommand = "mix credo suggest --strict --format=flycheck --read-from-stdin ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    rootMarkers = {"mix.exs", "mix.lock"}
}

local languages = {
    typescript = {eslint},
    javascript = {eslint},
    typescriptreact = {eslint},
    javascriptreact = {eslint},
    vue = {eslint},
    elixir = {credo}
}

local efm_capabilities = vim.lsp.protocol.make_client_capabilities()
efm_capabilities.textDocument.completion.completionItem.snippetSupport = true
efm_capabilities.textDocument.completion.completionItem.resolveSupport = {properties = {'documentation', 'detail', 'additionalTextEdits'}}

require"lspconfig".efm.setup {
    capabilities = efm_capabilities,
    root_dir = require"lspconfig".util.root_pattern("yarn.lock", "lerna.json", "mix.exs", "mix.lock", ".git"),
    init_options = {documentFormatting = true, codeAction = true},
    filetypes = vim.tbl_keys(languages),
    settings = {rootMarkers = {".git/"}, languages = languages}
}
