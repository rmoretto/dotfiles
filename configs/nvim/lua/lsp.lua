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
local lspconfig = require'lspconfig'
local lspconfig_configs = require'lspconfig/configs'
local lspconfig_util = require 'lspconfig/util'

local function on_new_config(new_config, new_root_dir)
  local function get_typescript_server_path(root_dir)
    local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
    return project_root and (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
      or ''
  end

  if
    new_config.init_options
    and new_config.init_options.typescript
    and new_config.init_options.typescript.serverPath == ''
  then
    new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
  end
end

local volar_cmd = {'volar-server', '--stdio'}
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

lspconfig_configs.volar_api = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,
    filetypes = { 'vue'},
    -- If you want to use Volar's Take Over Mode (if you know, you know)
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        serverPath = ''
      },
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
          getDocumentSelectionRequest = false,
        },
      }
    },
  }
}
lspconfig.volar_api.setup{}

lspconfig_configs.volar_doc = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,

    filetypes = { 'vue'},
    -- If you want to use Volar's Take Over Mode (if you know, you know):
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        serverPath = ''
      },
      languageFeatures = {
        documentHighlight = true,
        documentLink = true,
        codeLens = { showReferencesNotification = true},
        -- not supported - https://github.com/neovim/neovim/pull/14122
        semanticTokens = false,
        diagnostics = true,
        schemaRequestService = true,
      }
    },
  }
}
lspconfig.volar_doc.setup{}

lspconfig_configs.volar_html = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,

    filetypes = { 'vue'},
    -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
      typescript = {
        serverPath = ''
      },
      documentFeatures = {
        selectionRange = true,
        foldingRange = true,
        linkedEditingRange = true,
        documentSymbol = true,
        -- not supported - https://github.com/neovim/neovim/pull/13654
        documentColor = false,
        documentFormatting = {
          defaultPrintWidth = 100,
        },
      }
    },
  }
}
lspconfig.volar_html.setup{}


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

-- GDScript
require'lspconfig'.gdscript.setup{}


