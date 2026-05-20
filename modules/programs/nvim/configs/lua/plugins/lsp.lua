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
	keymap.set({ "n", "v" }, "<leader>a", "<cmd>Lspsaga code_action<cr>", opts)
	keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
	keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts)
	-- keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
end

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = lsp_location.vue_ts_plugin,
	languages = { "vue" },
	configNamespace = "typescript",
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
			{ "b0o/schemastore.nvim" },
		},
		opts = {
			servers = {
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
				expert = {
					cmd_env = {
						RELEASE_DISTRIBUTION = "sname",
					},
					settings = {
						dialyzerEnabled = false,
						mixEnv = "test",
					},
				},
				eslint = true,
				html = true,
                jsonls = true,
				marksman = true,
				rust_analyzer = true,
				lua_ls = true,
				pylsp = true,
				ts_ls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
					init_options = {
						plugins = { vue_plugin },
					},
				},
				vue_ls = true,
				nil_ls = true,
				gdscript = true,
				qmlls = true,
				ols = true,
				efm = {
					settings = {
						rootMarkers = { ".git/" },
						languages = {
							elixir = {
								-- Mix Credo
								{
									lintCommand = "mix credo suggest --format=flycheck --read-from-stdin ${INPUT}",
									lintStdin = true,
									lintFormats = { "%f:%l:%c: %t: %m", "%f:%l: %t: %m" },
									lintIgnoreExitCode = true,
									rootMarkers = { "mix.lock", "mix.exs" }
								},
							},
						},
					},
				},
				-- arduino_language_server = true,
				-- sqlls = true,
				-- tailwindcss = true,
				-- terraformls = true,
				-- zls = true,
				-- erlangls = true,
				-- gopls = true,
				-- elixirls = true,
				-- ansiblels = true,
				-- awk_ls = true,
				-- jsonls = {
				-- 	settings = {
				-- 		json = {
				-- 			schemas = require("schemastore").json.schemas(),
				-- 			validate = { enable = true },
				-- 		},
				-- 	},
				-- },
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(_)
					keymaps()
				end,
			})

			local function setup_server(lsp_name, server_opts)
				if server_opts == nil then
					server_opts = {}
				end

				server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)

				if lsp_location[lsp_name] then
					server_opts.cmd = lsp_location[lsp_name]
				end

				vim.lsp.config(lsp_name, server_opts)
				vim.lsp.enable(lsp_name)
			end

			for server, server_opts in pairs(opts.servers) do
				opts = server_opts == true and {} or server_opts
				setup_server(server, opts)
			end
		end,
	},

	-- Lsp Saga
	{
		"nvimdev/lspsaga.nvim",
		opts = {
			symbol_in_winbar = {
				enable = true,
				folder_level = 4,
			},
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
