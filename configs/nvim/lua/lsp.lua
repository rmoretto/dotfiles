-- Bash Config
require'lspconfig'.bashls.setup{
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- Elixir Config
require'lspconfig'.elixirls.setup{
    cmd = { "/home/rodrigo/.local/bin/language_server.sh" },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(c)
        require 'illuminate'.on_attach(c)
    end,
}

-- TypeScript Config
require'lspconfig'.tsserver.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(c)
        require 'illuminate'.on_attach(c)
    end,
}

-- HTML Config
require'lspconfig'.html.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(c)
    require 'illuminate'.on_attach(c)
  end,
}

-- Vue Config
require'lspconfig'.vuels.setup{
  on_attach = function(c)
    require 'illuminate'.on_attach(c)
  end,
}


-- CSS Config
require'lspconfig'.cssls.setup {
  cmd = { "vscode-css-language-server", "--stdio" },
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(c)
    require 'illuminate'.on_attach(c)
  end,
}

-- EFM LS
local eslint = {
    lintCommand = "yarn eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"}
}

local credo = {
    lintCommand = "mix credo suggest --strict --format=flycheck --read-from-stdin ${INPUT} --ignore Credo.Check.Readability.TrailingBlankLine,Credo.Check.Readability.TrailingWhiteSpace",
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

require"lspconfig".efm.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  root_dir = require"lspconfig".util.root_pattern("yarn.lock", "lerna.json", "mix.exs", "mix.lock", ".git"),
  init_options = {documentFormatting = true, codeAction = true},
  filetypes = vim.tbl_keys(languages),
  settings = {rootMarkers = {".git/"}, languages = languages, lintDebounce = 1000000000},
  on_attach = function(c)
    require 'illuminate'.on_attach(c)
  end,
}

-- Omnimerda 
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/rodrigo/.local/ominimerda/run"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

-- Rust
require'lspconfig'.rust_analyzer.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}


