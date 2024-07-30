local utils = require("utils")
local lsp_location = require("lsp_location")

local function keymaps()
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true }

	keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gr", vim.lsp.buf.references, opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "gs", vim.lsp.buf.type_definition, opts)
	keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
	keymap.set("n", "<leader>e", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts)
	keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts)
	-- keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
end

local tsdk = function()
    return vim.fn.getcwd() .. "/node_modules/typescript/lib"
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ansiblels = true,
				awk_ls = true,
				bashls = true,
				cssls = {
					single_file_support = false,
					settings = {
						css = { validate = true },
						scss = { validate = false },
						less = { validate = true },
					},
				},
				dockerls = true,
				efm = {
					init_options = { documentFormatting = true },
					settings = {
						languages = {
							elixir = {
								{
									lintCommand = [[mix credo suggest --format=flycheck ${INPUT} | sed -e 's/\ D:\ /\ n:\ /g' -e 's/\ R:\ /\ i:\ /g' -e 's/\ C:\ /\ i:\ /g' -e 's/\ F:\ /\ w:\ /g']],
									lintStdin = false,
									lintFormats = { "%f:%l:%c: %t: %m", "%f:%l: %t: %m" },
									rootMarkers = { "mix.lock", "mix.exs" },
								},
							},
						},
					},
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"elixir",
					},
				},
				elixirls = true,
				erlangls = true,
				eslint = true,
				gopls = true,
				html = true,
				jsonls = true,
				marksman = true,
				pyright = true,
				rust_analyzer = true,
				sqlls = true,
				lua_ls = true,
				tailwindcss = true,
				terraformls = true,
				tsserver = {
                    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = lsp_location.vue_ts_plugin,
                                languages = {"javascript", "typescript", "vue"},
                            },
                        },
                    },
                    flags = { debounce_text_changes = 50 }
                },
				volar = {
                    -- filetypes = { "vue" },
                    -- -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
                    -- init_options = {
                    --     vue = {
                    --         hybridMode = false,
                    --     },
                    --     typescript = {
                    --         tsdk = tsdk()
                    --     },
                    -- },
                    capabilities = {
                        workspace = {
                            didChangeWatchedFiles = {
                                dynamicRegistration = true,
                            },
                        },
                    },
				},
				arduino_language_server = true,
				nil_ls = true,
				unocss = true,
				gdscript = true,
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local cmp = require("cmp_nvim_lsp")
			-- local illuminate = require("illuminate")
			-- Get base capabilities
			local function base_capabilities(additional_capabilities)
                if additional_capabilities == nil then
                    additional_capabilities = {}
                end
				local cmp_capabilities = cmp.default_capabilities()
                return vim.tbl_deep_extend('force', additional_capabilities, cmp_capabilities)
				-- return utils.table_merge(cmp_capabilities, additional_capabilities)
			end

			-- Get base on attach
			local function base_on_attach()
				return function(c)
					-- illuminate.on_attach(c)
				end
			end

			-- Server setup main function
			local function setup_server(lsp_name, server_opts)
				if server_opts == nil then
					server_opts = {}
				end

				server_opts.capabilities = vim.tbl_deep_extend("force", server_opts.capabilities or {}, base_capabilities())

				local on_attach = server_opts.on_attach or base_on_attach()
				server_opts.on_attach = on_attach

			    -- See nvim.nix modules for the lsp_location file generation
				if lsp_location[lsp_name] then
					server_opts.cmd = lsp_location[lsp_name]
				end

				lspconfig[lsp_name].setup(server_opts)
			end

			for server, server_opts in pairs(opts.servers) do
				server_opts = server_opts == true and {} or server_opts
				setup_server(server, server_opts)
			end

			keymaps()
		end,
	},

    -- Lsp Saga
    {
        'nvimdev/lspsaga.nvim',
        opts = {
            symbol_in_winbar = {
                enable = true,
		        folder_level = 4,
            }
        },
        config = function(_, opts)
            require('lspsaga').setup(opts)
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        }
    }
}
