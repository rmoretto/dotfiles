local keymap = vim.keymap
local utils_cmp = require("utils.cmp")

return {
	-- Nvim Cmp
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/vim-vsnip-integ",
			"rafamadriz/friendly-snippets",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = true

			return {
				completion = { completeopt = "menu,menuone,noinsert" },
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-g>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = utils_cmp.confirm({ select = auto_select }),
					["<C-y>"] = utils_cmp.confirm({ select = true }),
					["<S-CR>"] = utils_cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
				}, {
					{ name = "path" },
					{ name = "buffer" },
					{ name = "emoji" },
					{ name = "nvim_lsp", trigger_characters = { "-" } },
				}),
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			}
		end,
	},

	{
		"mhartington/formatter.nvim",
		opts = function()
			local function mix_format()
				return { exe = "mix", args = { "format", "mix.exs", "-" }, stdin = true }
			end

			local function terraform()
				return { exe = "terraform", args = { "fmt", "-write=false" }, stdin = true }
			end

			local function nix()
				return { exe = "nix", args = { "fmt" }, stdin = true }
			end

			local stylua = require("formatter.filetypes.lua").stylua
			local prettier = require("formatter.filetypes.javascript").prettier
			local black = require("formatter.filetypes.python").black
			local rustfmt = {
				exe = "rustfmt --edition 2021",
				stdin = true,
			}

			return {
				logging = true,
				filetype = {
					elixir = { mix_format },
					lua = { stylua },
					javascript = { prettier },
					javascriptreact = { prettier },
					typescript = { prettier },
					typescriptreact = { prettier },
					vue = { prettier },
					html = { prettier },
					json = { prettier },
					css = { prettier },
					scss = { prettier },
					sass = { prettier },
					python = { black },
					rust = { rustfmt },
					terraform = { terraform },
					nix = { nix },
				},
			}
		end,
		config = function(_, opts)
			require("formatter").setup(opts)

			local key_opts = { noremap = true, silent = true }
			keymap.set("n", "<leader>f", ":Format<CR> :w<CR>", key_opts)
		end,
	},

	-- toggleterm
	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = [[<C-\>]],
			shade_terminals = false,
			direction = "float",
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			keymap.set("t", "<C-N>", [[<C-\><C-N>]], { noremap = true, silent = true })
		end,
	},

	-- vim test
	{
		"vim-test/vim-test",
		config = function(_, _)
			vim.cmd([[
      let test#strategy = "toggleterm"
      ]])

			local opts = { noremap = true, silent = true }
			keymap.set("n", "t<C-n>", ":TestNearest<CR>", opts)
			keymap.set("n", "t<C-f>", ":TestFile<CR>", opts)
			keymap.set("n", "t<C-s>", ":TestSuite<CR>", opts)
			keymap.set("n", "t<C-l>", ":TestLast<CR>", opts)
			keymap.set("n", "t<C-g>", ":TestVisit<CR>", opts)
		end,
	},

	-- colors in code
	-- {
	-- 	"drenoprata10/nvim-highlight-colors",
	-- 	opts = {
	-- 		render = "virtual",
	-- 		virtual_symbol = "■",
	-- 	},
	-- },

	-- LazyDev
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},

	-- Mini Surround
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {
			-- Add custom surroundings to be used on top of builtin ones. For more
			-- information with examples, see `:h MiniSurround.config`.
			custom_surroundings = nil,

			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,

			-- Module mappings. Use `''` (empty string) to disable ne.
			mappings = {
				add = "<leader>aa", -- Add surrunding in Normal and Visual modes
				delete = "<leader>ad", -- Delete surrounding
				find = "<leader>af", -- Find surrounding (to the right)
				find_left = "<leader>aF", -- Find surrounding (to the left)
				highlight = "<leader>ah", -- Highlight surrounding
				replace = "<leader>ar", -- Replace surrounding
				update_n_lines = "<leader>an", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},

			-- Number of lines within which surrounding is searched
			n_lines = 20,

			-- Whether to respect selection type:
			-- - Place surroundings on separate lines in linewise mode.
			-- - Place surroundings on each line in blockwise mode.
			respect_selection_type = false,

			-- How to search for surrounding (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
			-- see `:h MiniSurround.config`.
			search_method = "cover",

			-- Whether to disable showing non-error feedback
			silent = false,
		},
	},

	-- Vim Printer
	{
		"meain/vim-printer",
		config = function()
			vim.g.vim_printer_items = {
				elixir = 'IO.inspect({$}, label: "{$}")',
				vue = 'console.log("{$}", {$})',
			}
		end,
	},

	{
		"dmmulroy/ts-error-translator.nvim",
		config = true,
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
	},

	-- Vim exchange
	{ "tommcdo/vim-exchange" },

	-- pobrema
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

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
}
