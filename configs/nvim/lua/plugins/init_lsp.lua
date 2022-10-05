local keymap = vim.keymap
local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'
local configs = require 'lspconfig.configs'

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
-- Volar
-- Volar
local function on_new_config(new_config, new_root_dir)
    local function get_typescript_server_path(root_dir)
        local project_root = util.find_node_modules_ancestor(root_dir)
        return project_root and
                   (util.path.join(project_root, 'node_modules', 'typescript',
                                   'lib', 'tsserverlibrary.js')) or ''
    end

    if new_config.init_options and new_config.init_options.typescript and
        new_config.init_options.typescript.serverPath == '' then
        new_config.init_options.typescript.serverPath =
            get_typescript_server_path(new_root_dir)
    end
end

local volar_cmd = {'volar-server', '--stdio'}
local volar_root_dir = util.root_pattern 'package.json'

if not configs.volar_api then
    configs.volar_api = {
        default_config = {
            cmd = volar_cmd,
            root_dir = volar_root_dir,
            on_new_config = on_new_config,
            on_attach = function(c)
                require 'illuminate'.on_attach(c)
            end,
            capabilities = capabilities,
            filetypes = {'vue'},
            -- If you want to use Volar's Take Over Mode (if you know, you know)
            -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
            init_options = {
                typescript = {serverPath = ''},
                languageFeatures = {
                    references = true,
                    definition = true,
                    typeDefinition = true,
                    callHierarchy = true,
                    hover = true,
                    rename = true,
                    renameFileRefactoring = true,
                    signatureHelp = true,
                    codeAction = true,
                    workspaceSymbol = true,
                    completion = {
                        defaultTagNameCase = 'both',
                        defaultAttrNameCase = 'kebabCase',
                        getDocumentNameCasesRequest = false,
                        getDocumentSelectionRequest = false
                    }
                }
            }
        }
    }
end
lspconfig.volar_api.setup {}

if not configs.volar_doc then
    configs.volar_doc = {
        default_config = {
            cmd = volar_cmd,
            root_dir = volar_root_dir,
            on_new_config = on_new_config,
            on_attach = function(c)
                require 'illuminate'.on_attach(c)
            end,
            capabilities = capabilities,
            filetypes = {'vue'},
            -- If you want to use Volar's Take Over Mode (if you know, you know):
            -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
            init_options = {
                typescript = {serverPath = ''},
                languageFeatures = {
                    documentHighlight = true,
                    documentLink = true,
                    codeLens = false,
                    -- not supported - https://github.com/neovim/neovim/pull/14122
                    semanticTokens = false,
                    diagnostics = true,
                    schemaRequestService = true
                }
            }
        }
    }
end
lspconfig.volar_doc.setup {}

if not configs.volar_html then
    configs.volar_html = {
        default_config = {
            cmd = volar_cmd,
            root_dir = volar_root_dir,
            on_new_config = on_new_config,
            on_attach = function(c)
                require 'illuminate'.on_attach(c)
            end,
            capabilities = capabilities,
            filetypes = {'vue'},
            -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
            -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            init_options = {
                typescript = {serverPath = ''},
                documentFeatures = {
                    selectionRange = true,
                    foldingRange = true,
                    linkedEditingRange = true,
                    documentSymbol = true,
                    -- not supported - https://github.com/neovim/neovim/pull/13654
                    documentColor = false,
                    documentFormatting = {defaultPrintWidth = 100}
                }
            }
        }
    }
end
lspconfig.volar_html.setup {}

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

-- Python
require'lspconfig'.pyright.setup {}

-- GDScript
require'lspconfig'.gdscript.setup{}

-- Dart
require'lspconfig'.dartls.setup{
    cmd = {"dart", "/home/rodrigo/snap/flutter/common/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp"} 
}

-- CLangD
require'lspconfig'.clangd.setup{
    cmd = { "clangd-12" }
}

-- Terraform
require'lspconfig'.terraformls.setup{}


local opts = { noremap = true, silent = true }

vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
keymap.set("n", "gr", vim.lsp.buf.references, opts)
keymap.set("n", "K", vim.lsp.buf.hover, opts)
keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)


