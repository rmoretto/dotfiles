return {
	-- PLS HELP ME
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- 	config = function(_, opts)
	-- 		-- Copied from: https://github.com/pmizio/typescript-tools.nvim/blob/a4109c70e7d6a3a86f971cefea04ab6720582ba9/lua/typescript-tools/init.lua#L15
	-- 		local lsp_location = require("lsp_location")
	-- 		local configs = require("lspconfig.configs")
	-- 		local util = require("lspconfig.util")
	-- 		local rpc = require("typescript-tools.rpc")
	--
	-- 		configs["typescript-tools"] = {
	-- 			default_config = {
	-- 				cmd = function(...)
	-- 					return rpc.start(...)
	-- 				end,
	-- 				filetypes = {
	-- 					"javascript",
	-- 					"javascriptreact",
	-- 					"javascript.jsx",
	-- 					"typescript",
	-- 					"typescriptreact",
	-- 					"typescript.tsx",
	-- 					"vue",
	-- 				},
	-- 				init_options = {
	-- 					plugins = {
	-- 						{
	-- 							name = "@vue/typescript-plugin",
	-- 							location = lsp_location.vue_ts_plugin,
	-- 							languages = { "javascript", "typescript", "vue" },
	-- 						},
	-- 					},
	-- 				},
	-- 				root_dir = function(fname)
	-- 					-- INFO: stealed from:
	-- 					-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
	-- 					local root_dir = util.root_pattern("tsconfig.json")(fname)
	-- 						or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
	--
	-- 					-- INFO: this is needed to make sure we don't pick up root_dir inside node_modules
	-- 					local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
	-- 					if node_modules_index and node_modules_index > 0 then
	-- 						root_dir = root_dir:sub(1, node_modules_index - 2)
	-- 					end
	--
	-- 					return root_dir
	-- 				end,
	-- 				single_file_support = true,
	-- 			},
	-- 		}
	--
	-- 		require("typescript-tools").setup({
	-- 			settings = {
	-- 				tsserver_plugins = {
	-- 					"@vue/typescript-plugin",
	-- 				}
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- typescript me salva
	{
		"dmmulroy/tsc.nvim",
		opts = {
			bin_path = "vue-tsc",
		},
		config = function(_, opts)
			require("tsc").setup(opts)
		end,
	},

	-- got to auto-imported component
	{ "catgoose/vue-goto-definition.nvim" },

	-- automatically close tags in vue/html files
	{
		"windwp/nvim-ts-autotag",
		config = function(_, _)
			require("nvim-ts-autotag").setup()
		end,
	},

	-- fix shitty comments in .vue file
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			local native_get_option = vim.filetype.get_option
			---@diagnostic disable-next-line: duplicate-set-field
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or native_get_option(filetype, option)
			end
		end,
	},
}
